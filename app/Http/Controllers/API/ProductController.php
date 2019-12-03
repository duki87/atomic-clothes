<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Product;
use App\Traits\ImagesTrait;
use App\Traits\ManualPaginationTrait;
use Carbon\Carbon;

class ProductController extends Controller
{
    use ImagesTrait, ManualPaginationTrait;

    public function index()
    {
        //
    }

    public function store(Request $request)
    {
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
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : ''
        ]);
        if($product->save()) {
            return ['message' => 'success', 'product_id' => $product->id];
        }
        return ['message' => 'failed']; 
    }

    public function show($id)
    {
        //
    }

    public function update(Request $request, $id)
    {
        //
    }

    public function destroy($id)
    {
        //
    }
}
