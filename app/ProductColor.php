<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductColor extends Model
{
    protected $fillable = [
        'product_id', 'color'
    ];

    public function color_variant_images()
    {
        return $this->hasMany('App\ProductImages', 'color_id');
    }

    public function variants()
    {
        return $this->hasMany('App\ProductVariant', 'color_id');
    }

    public function product()
    {
        return $this->hasOne('App\Product', 'id', 'product_id');
    }
}
