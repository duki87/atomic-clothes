<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Product;
use App\Category;
use App\Brand;
use App\Traits\ImagesTrait;
use App\Traits\ManualPaginationTrait;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ProductController extends Controller
{
    use ImagesTrait, ManualPaginationTrait;

    public function index($status = null)
    {
        $products = Product::orderBy('created_at', 'desc')->with('variants')->get();
        $products->transform(function($product) {
            $product->mainCatTitle = Category::where(['id' => $product->main_category_id])->first()['title'];
            $product->subCatTitle = Category::where(['id' => $product->sub_category_id])->first()['title'];
            $product->catTitle = Category::where(['id' => $product->category_id])->first()['title'];
            $product->brandTitle = Brand::where(['id' => $product->brand_id])->first()['title'];
            $product->tags = $product->tags ? json_decode($product->tags) : [];
            return $product;
        });
        $products = self::paginate($products, $products->count(), 5);
        return ['products' => $products];
    }

    public function store(Request $request)
    {
        $directory = strtolower(Carbon::now()->format('dmYHis').'-'.Str::random(16));
        Storage::disk('images')->makeDirectory('products/'.$directory);
        $product = new Product([
            'title' => 'Product title',
            'description' => 'Product description must have at least 20 characters',
            'price' => 0.00,
            'discount' => 0,
            'image_folder'  => $directory,
            'cover_image' => 'Product cover image',
            'main_category_id'  =>  0,
            'sub_category_id'  =>  0,
            'category_id'  =>  0,
            'brand_id'  =>  0,
            'code'  =>  $this->generateCode(),
            'tags'  =>  json_encode(['product', 'tags']),
        ]);
        if($product->save()) {
            return ['product_id' => $product->id, 'image_folder' => $directory];
        }
    }

    public function show($id)
    {
        $product = Product::where(['id' => $id])->with('product_images')->first();
        return ['product' => $product];
    }

    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'title' => 'required|string|min:2',
            'description' => 'string|min:20',
            'main_category_id' => 'required|integer',
            'sub_category_id' => 'required|integer',
            'category_id' => 'required|integer',
            'brand_id' => 'required|integer',
            'price' => 'required|regex:/^\d+(\.\d{1,2})?$/'
        ]); 
        $update = Product::where(['id' => $id])->update([
            'title' => $request->title,
            'description' => $request->description,
            'price' => $request->price,
            'discount' => $request->discount,
            'image_folder'  => $request->image_folder,
            'cover_image' => $request->cover_image,
            'main_category_id'  =>  $request->main_category_id,
            'sub_category_id'  =>  $request->sub_category_id,
            'category_id'  =>  $request->category_id,
            'brand_id'  =>  $request->brand_id,
            'code'  =>  $this->generateCode(),
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : '',
            'status' => 1
        ]);
        if($update) {
            return ['message' => 'success'];
        }
        return ['message' => 'failed']; 
    }

    public function destroy($id)
    {
        $product = Product::where(['id' => $id])->with('variants')->first();
        $this->destroyProductImages($id);  
        Storage::disk('images')->deleteDirectory('products/'.$product->image_folder);
        $product->delete();
    }

    private function generateCode() 
    {
        $lastCode = Product::orderBy('created_at', 'desc')->first()['code'];
        if($lastCode == null) {
            $lastCode = 0;
        }
        (int)$lastCode++;
        $lastCode = sprintf("%06s", $lastCode);
        return (string)$lastCode;
    }
}
