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
        $variants = ProductVariant::orderBy('created_at', 'desc')
            ->with('variant_images')
            ->with('product')->get();
        $variants->transform(function($variant) {
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
            'color_id' => 'required|integer',
            'stock' => 'required|integer',
        ]);
        $variant = new ProductVariant([
            'product_id' => $request->product_id,
            'size' => $request->size,
            'sku' => $request->sku,
            'color_id' => $request->color_id,
            'stock' => $request->stock,
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : '',
        ]);
        if($variant->save()) {
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function show($id)
    {
        $variant = ProductVariant::where(['id' => $id])->with('variant_color', 'variant_color.color_variant_images', 'product', 'product.colors')->first();     
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
            'color_id' => 'required|integer',
            'stock' => 'required|integer',
        ]);
        $variant = ProductVariant::where(['id' => $id])->update([
            'product_id' => $request->product_id,
            'size' => $request->size,
            'sku' => $request->sku,
            'color_id' => $request->color_id,
            'stock' => $request->stock,
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : '',
        ]);
        if($variant) {
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function destroy($id)
    {
        $variant = ProductVariant::where(['id' => $id])->first();
        if($variant->delete()) {
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function getVariantsByProductId($product_id)
    {
        $variants = ProductVariant::where(['product_id' => $product_id])
            ->orderBy('created_at', 'desc')
            ->with('variant_color', 'variant_color.color_variant_images', 'product')
            ->get();
        $variants->transform(function($variant) {
            $variant->tags = $variant->tags ? json_decode($variant->tags) : [];
            return $variant;
        });
        $variants = self::paginate($variants, $variants->count(), 5);
        return ['variants' => $variants];
    }
}
