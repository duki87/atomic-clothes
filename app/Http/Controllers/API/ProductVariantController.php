<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Product;
use App\ProductImages;
use App\ProductVariant;
use App\Traits\ImagesTrait;
use App\Traits\ManualPaginationTrait;

class ProductVariantController extends Controller
{
    use ImagesTrait, ManualPaginationTrait;

    public function index()
    {
        $variants = ProductVariant::orderBy('created_at', 'desc')->with('variant_images')->with('product')->get();
        $variants->transform(function($variant) {
            $variant->product_name = Product::where(['id' => $variant->product_id])->first()['title'];
            $variant->tags = $variant->tags ? json_decode($variant->tags) : [];
            return $variant;
        });
        $variants = self::paginate($variants, $variants->count(), 5);
        return ['variants' => $variants];
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
/*                 $variant_image = ProductImages::where(['id' => $imgId])->update([
                    'variant_id' => $variant->id
                ]); */
                $product_image = ProductImages::where(['id' => $imgId])->first();
                $variant_image = new ProductImages([
                    'product_id' => null,
                    'variant_id' => $variant->id,
                    'image' => $product_image->image
                ]);
                $variant_image->save();
            }
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function show($id)
    {
        $variant = ProductVariant::where(['id' => $id])->with('variant_images')->with('product.product_images')->first();
        if($variant) {
            return ['variant' => $variant];
        }
        return ['message' => 'failed'];
    }

    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'size' => 'required|string|min:1|max:5',
            'sku' => 'required|string|max:20',
            'color' => 'required|string|max:255',
            'stock' => 'required|integer',
        ]);
        $variant = ProductVariant::where(['id' => $id])->update([
            'product_id' => $request->product_id,
            'size' => $request->size,
            'sku' => $request->sku,
            'color' => $request->color,
            'stock' => $request->stock,
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : '',
        ]);
        if($variant) {
            $all_variant_images = ProductImages::where(['variant_id' => $id])->pluck('id')->toArray();
            $variant_images = $request->variant_images;
            foreach($all_variant_images as $variant_image) {
                if(!in_array($variant_image, $variant_images)) {
                    ProductImages::where(['id' => $variant_image])->delete();
                }
            }
            foreach($variant_images as $img_id) {
                $variant_image = ProductImages::where('id', '=', $img_id)->where('variant_id', '=', null)->first();
                if($variant_image) {
                    $new_variant_image = new ProductImages([
                        'variant_id' => $id,
                        'image' => $variant_image->image
                    ]);
                    $new_variant_image->save();
                }
            }
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function destroy($id)
    {
        $variant = ProductVariant::where(['id' => $id])->with('variant_images')->first();
        $variant_images = $variant->variant_images;
        foreach($variant_images as $image) {
            ProductImages::where(['id' => $image->id])->delete();
        }
        if($variant->delete()) {
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }
}
