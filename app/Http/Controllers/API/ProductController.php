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

class ProductController extends Controller
{
    use ImagesTrait, ManualPaginationTrait;

    public function index()
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
        //dd($this->generateCode());
        $this->validate($request, [
            'title' => 'required|string|min:2',
            'description' => 'string|min:20',
            'main_category_id' => 'required|integer',
            'sub_category_id' => 'required|integer',
            'category_id' => 'required|integer',
            'brand_id' => 'required|integer',
            'price' => 'required|regex:/^\d+(\.\d{1,2})?$/',
        ]); 
        if($request->has('cover_image') && !empty($request->cover_image)) {
            $directory = strtolower(str_replace(' ', '.', $request->title).'.'.Carbon::now()->format('YmdHs'));
            $cover_image = self::uploadConstraintImage($request->cover_image, 1024, 'jpg', 'products/'.$directory);
        }
        $product = new Product([
            'title' => $request->title,
            'description' => $request->description,
            'price' => $request->price,
            'discount' => $request->discount,
            'image_folder'  => $directory,
            'cover_image' => isset($cover_image) ? $cover_image : '',
            'main_category_id'  =>  $request->main_category_id,
            'sub_category_id'  =>  $request->sub_category_id,
            'category_id'  =>  $request->category_id,
            'brand_id'  =>  $request->brand_id,
            'code'  =>  $this->generateCode(),
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : ''
        ]);
        if($product->save()) {
            return ['message' => 'success', 'product_id' => $product->id];
        }
        return ['message' => 'failed']; 
    }

    public function show($id)
    {
        $product = Product::where(['id' => $id])->with('product_images')->first();
        return ['product' => $product];
    }

    public function update(Request $request, $id)
    {
        //
    }

    public function destroy($id)
    {
        $product = Product::where(['id' => $id])->with('variants')->first();
        self::deleteImage('products/'.$product->image_folder, $product->cover_image);
        Storage::disk('images')->deleteDirectory('products/'.$product->image_folder);
        $product->delete();
    }

    private function generateCode() 
    {
        $lastCode = Product::orderBy('created_at', 'desc')->first()['code'];
        (int)$lastCode++;
        $lastCode = sprintf("%06s", $lastCode);
        return (string)$lastCode;
    }
}
