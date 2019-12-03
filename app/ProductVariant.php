<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductVariant extends Model
{
    protected $fillable = [
        'product_id', 'sku', 'size', 'color', 'stock', 'tags'
    ];

    public function images()
    {
        return $this->hasMany('App\ProductImages', 'variant_id');
    }
}
