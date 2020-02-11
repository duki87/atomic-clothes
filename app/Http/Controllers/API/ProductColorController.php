<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Product;
use App\ProductColor;
use App\ProductImages;
use App\Traits\ImagesTrait;

class ProductColorController extends Controller
{
    public function index()
    {

    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'color' => 'required|string|min:1|max:50',
            'product_id' => 'required|integer',
        ]);
        $colorVariant = new ProductColor([
            'product_id' => $request->product_id,
            'color' => $request->color,
        ]);
        if($colorVariant->save()) {
            foreach($request->color_variant_images as $imgId) {
                $product_image = ProductImages::where(['id' => $imgId, 'color_id' => 0])->update([
                    'color_id' => $colorVariant->id
                ]);
            }
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function show($id)
    {
        $colorVariant = ProductColor::where(['id' => $id])->with('color_variant_images')->first();
        return ['colorVariant' => $colorVariant];
    }

    public function destroy($id)
    {
        $colorVariant = ProductColor::where(['id' => $id])->with('color_variant_images')->first();
        $colorId = $colorVariant->id;
        $images = $colorVariant->color_variant_images;
        if($colorVariant->delete()) {
            foreach($images as $image) {
                $product_image = ProductImages::where(['color_id' => $colorId])->update([
                    'color_id' => 0
                ]);
            }
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function getProductColorVariants($product_id)
    {
        $colorVariants = ProductColor::where(['product_id' => $product_id])->with('color_variant_images')->get();
        return ['colorVariants' => $colorVariants];
    }
}
