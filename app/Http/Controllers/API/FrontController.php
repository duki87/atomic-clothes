<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Product;
use App\ProductVariant;
use App\ProductImages;
use App\Category;
use App\Brand;
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
        $category = Category::where(['url' => $categoryURL])
        ->with('main_category')
        ->with('categories')
        ->first();
        //Check if filters are set
        if($filters != 'all') {
            $filtersToApply = json_decode($filters, true);
        }
        $colorFilter = isset($filtersToApply['color']) ? $filtersToApply['color'] : '';
        $products = Product::where([
            ['main_category_id', '=', $category->main_category->id],
            ['sub_category_id', '=', $category->id]
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
        // if(isset($filtersToApply['color'])) { 
        //     $colorFilter = $filtersToApply['color'];
        //     $products = $products->colors->filter(function($color) use ($colorFilter) {
        //         return $color->id == $colorFilter;
        //     });
        // }
        $products = self::paginate($products, $products->count(), 3);
        return response([
            'products' => $products, 
            'filters' => ['categories' => $category->categories, 'brands' => $brands, 'colors' => $colorList],
            'applied' => $filters
        ]);
    }

    public function getProduct($product)
    {
        $product = Product::where(['url' => $product])
        ->with('category', 'main_category', 'sub_category', 'brand')
        ->with('colors')       
        ->with('colors.variants')
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

    private function filterBy($filters) 
    {
        //Make product search filters
        $where = [];
        if(isset($filters['category'])) {
            $where['category_id'] = $filters['category']; 
        }
        if(isset($filters['brand'])) {
            $where['brand_id'] = $filters['brand']; 
        }
        return $where;
    }
}
