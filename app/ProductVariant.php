<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductVariant extends Model
{
    protected $fillable = [
        'product_id', 'sku', 'size', 'color', 'stock', 'tags'
    ];

    public function variant_images()
    {
        return $this->hasMany('App\ProductImages', 'variant_id');
    }

    public function product()
    {
        return $this->hasMany('App\Product', 'id', 'product_id');
    }
}
