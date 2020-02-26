<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductVariant extends Model
{
    protected $fillable = [
        'product_id', 'sku', 'size', 'color_id', 'stock', 'tags'
    ];

    public function product()
    {
        return $this->hasOne('App\Product', 'id', 'product_id');
    }

    public function variant_color()
    {
        return $this->hasOne('App\ProductColor', 'id', 'color_id');
    }
}
