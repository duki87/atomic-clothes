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

class FrontController extends Controller
{
    use ManualPaginationTrait;

    public function getCollection($collectionURL)
    {
        $id = $this->returnCollectionID($collectionURL);
        $collection = Category::where([
            ['main', '=', $id],
            ['sub', '=', 0]
        ])->get();
        return ['collection' => $collection];
    }

    public function getCategory($collectionURL)
    {
        $id = $this->returnCollectionID($collectionURL);
        $collection = Category::where([
            ['main', '=', $id],
            ['sub', '=', 0]
        ])->get();
        return ['collection' => $collection];
    }

    public function getProducts($collectionURL, $categoryURL)
    {
        $products = Product::where([
            ['main_category_id', '=', $this->returnCollectionID($collectionURL)],
            ['sub_category_id', '=', $this->returnCategoryID($collectionURL, $categoryURL)]
        ])->get();
        $products->transform(function($product) {
            $product->subCatTitle = Category::where(['id' => $product->sub_category_id])->first()['title'];
            $product->catTitle = Category::where(['id' => $product->category_id])->first()['title'];
            $product->brandTitle = Brand::where(['id' => $product->brand_id])->first()['title'];
            $product->tags = $product->tags ? json_decode($product->tags) : [];
            return $product;
        });
        $products = self::paginate($products, $products->count(), 5);
        return ['products' => $products];
    }

    public function getProduct($product)
    {
        $product = Product::where(['url' => $product])->with('colors', 'colors.variants', 'colors.color_variant_images', 'variants')->get();
        $product->transform(function($product) {
            $product->mainCat = Category::select('title', 'url')->where(['id' => $product->main_category_id])->first();
            $product->subCat = Category::select('title', 'url')->where(['id' => $product->sub_category_id])->first();
            $product->cat = Category::select('title', 'url')->where(['id' => $product->category_id])->first();
            $product->brandTitle = Brand::where(['id' => $product->brand_id])->first()['title'];
            $product->tags = $product->tags ? json_decode($product->tags) : [];
            return $product;
        });
        return ['product' => $product];
    }

    private function returnCollectionID($collectionURL)
    {
        $collectionID = Category::where([
            ['main', '=', 0],
            ['url', '=', $collectionURL]
        ])->pluck('id')->first();
        return $collectionID;
    }

    private function returnCategoryID($collectionURL, $categoryURL)
    {
        $categoryID = Category::where([
            //['main', '=', 0],
            ['sub', '=', 0],
            ['url', '=', $categoryURL]
        ])->pluck('id')->first();
        return $categoryID;
    }
}
