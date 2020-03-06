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

    public function getProducts($collectionURL, $categoryURL)
    {
        $category = Category::where(['url' => $categoryURL])
        ->with('main_category')
        ->first();
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
        $products = self::paginate($products, $products->count(), 3);
        return response(['products' => $products]);
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
}
