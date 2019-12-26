<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Product;
use App\ProductImages;
use App\ProductVariant;

class ProductVariantController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'size' => 'required|string|min:1|max:5',
            'sku' => 'required|string|max:20',
            'color' => 'required|string|max:255',
            'stock' => 'required|integer',
        ]);
        $variant = new ProductVariant([
            'product_id' => $request->product_id,
            'size' => $request->size,
            'sku' => $request->sku,
            'color' => $request->color,
            'stock' => $request->stock,
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : '',
        ]);
        if($variant->save()) {
            foreach($request->variant_images as $imgId) {
                $variant_image = ProductImages::where(['id' => $imgId])->update([
                    'variant_id' => $variant->id
                ]);
            }
            return ['message' => 'success'];
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
