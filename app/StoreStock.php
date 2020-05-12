<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class StoreStock extends Model
{
    protected $fillable = [
        'store_id', 'product_id', 'variant_id', 'quantity'
    ];
    
    public function product_availability($store_id, $product_id, $varaint_id)
    {
        return $this->where(['store_id' => $store_id, 'product_id' => $product_id, 'variant_id' => $varaint_id])->first();
    }

    public function product()
    {
        return $this->belongsTo('App\Product', 'product_id', 'id');
    }

    public function variant()
    {
        return $this->belongsTo('App\ProductVariant', 'variant_id', 'id');
    }

    public function store()
    {
        return $this->belongsTo('App\Store', 'store_id', 'id');
    }
}
