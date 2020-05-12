<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Product;
use App\ProductVariant;
use App\ProductImages;
use App\StoreStocks;
use App\Category;
use App\Brand;
use App\Store;
use App\PromoCode;
use App\Cart;
use App\Traits\ManualPaginationTrait;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class FrontController extends Controller
{
    use ManualPaginationTrait;

    public function getCollection($collectionURL)
    {
        $category = Category::where(['url' => $collectionURL])
        ->with('sub_categories')
        ->first();
        return response(['collection' => $category->sub_categories]);
    }

    public function getProducts($collectionURL, $categoryURL, $filters = 'all')
    {
        $filtersToApply = [];
        $main_category = Category::where(['url' => $collectionURL])->first();
        $sub_category = Category::where(['url' => $categoryURL])->with('categories')->first();
        //Check if filters are set
        if($filters != 'all') {
            $filtersToApply = json_decode($filters, true);
        }
        $colorFilter = isset($filtersToApply['color']) ? $filtersToApply['color'] : '';
        $products = Product::where([
            ['main_category_id', '=', $main_category->id],
            ['sub_category_id', '=', $sub_category->id]
        ])
        ->with('category', 'main_category', 'sub_category', 'brand')
        ->with('colors')       
        ->with('colors.variants')
        ->with('colors.color_variant_images')
        ->get();
        $products->transform(function($product) {
            $product->tags = $product->tags ? json_decode($product->tags) : [];
            return $product;
        });
        $brands = $products->pluck('brand')->unique();
        $colors = $products->pluck('colors')->unique();
        $colorList = $colors->flatten(1);    
        if(isset($filtersToApply['category'])) {
            $categoryFilter = $filtersToApply['category'];
            $products = $products->filter(function($product) use ($categoryFilter) {
                return $product->category_id == $categoryFilter;
            });
        }
        if(isset($filtersToApply['brand'])) { 
            $brandFilter = $filtersToApply['brand'];
            $products = $products->filter(function($product) use ($brandFilter) {
                return $product->brand_id == $brandFilter;
            });
        }
        if(isset($filtersToApply['color']) && $filtersToApply['color'] != '') { 
            $colorFilter = $filtersToApply['color'];
            $products = $products->filter(function($product) use ($colorFilter) {
                foreach($product->colors as $color) {
                    if($color->color === $colorFilter) {
                        return $product;
                    }
                }
            });
        }
        $products = self::paginate($products, $products->count(), 3);
        return response([
            'products' => $products, 
            'filters' => ['categories' => $sub_category->categories, 'brands' => $brands, 'colors' => $colorList],
            'applied' => $filters
        ]);
    }

    public function getProduct($product)
    {
        $product = Product::where(['url' => $product])
        ->with('category', 'main_category', 'sub_category', 'brand')
        ->with('colors')       
        ->with('colors.variants')
        ->with('colors.variants.store_stocks')
        ->with('colors.variants.store_stocks.store')
        ->with('colors.color_variant_images')
        ->first();
        if($product) {
            $product->tags = $product->tags ? json_decode($product->tags) : [];
            return ['product' => $product];
        }
        $validator = Validator::make([], []); // Empty data and rules fields
        $validator->errors()->add('product', 'NOT_FOUND');
        throw new ValidationException($validator);
    }

    
    public function get_stores()
    {
        $stores = Store::get();
        return response(['stores' => $stores], 200);
    }

    public function check_promo_code(Request $request)
    {
        $coupon_no = $request->coupon_no;
        $coupon_series = $request->coupon_series;
        $promo_code = new PromoCode();
        $coupon = $promo_code->find($coupon_no, $coupon_series);
        $current_datetime = date('Y-m-d H:i:s');
        if($coupon) {
            //Check if promo code is already used
            if($coupon->status === 0) {
                return response(['error' => 'This promo code has been used.'], 500);
            }
            //Check if this promotion has started
            if($coupon->start > $current_datetime) {
                return response(['error' => 'This promotion is still not active.'], 500);
            }
            //Check if this coupon has not expired
            if($coupon->expire < $current_datetime) {
                return response(['error' => 'This code has expired. Please try another one.'], 500);
            }
            //Check if current authenticated user owns this code
            if($coupon->user_id && Auth::guard('web')->check()) {
                if($coupon->user_id !== Auth::guard('web')->id()) {
                    return response(['error' => 'This code does not belong to your account.'], 500);
                }
            }
            $apply = Cart::apply_discount_to_cart($coupon);
            if($apply === 'COUPON_NOT_APPLIED') {
                return response(['error' => 'There are no items in cart on which coupon can be applied.'], 500);
            }
            return response(['promo_code' => $coupon, 'applied' => $apply], 200);
        } else {
            return response(['error' => 'This code is not valid. Please try another one.'], 500);
        }
        return response(['error' => 'This coupon does not exist.'], 500);
    }

    public function remove_promo_code($coupon) 
    {
        $coupon_no = explode('-', $coupon)[1];
        $coupon_series = explode('-', $coupon)[0];
        $promo_code = new PromoCode();
        $coupon = $promo_code->find($coupon_no, $coupon_series);
        $remove = Cart::remove_coupon_from_cart($coupon);
        if($remove) {
            return response(['Coupon Removed'], 200);
        }        
        return response(['Something went wrong.'], 500);
    }

    // private function update_cart(PromoCode $coupon)
    // {
    //     return $cart;
    // }
}
