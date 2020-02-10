<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'main_category_id', 'sub_category_id', 'category_id', 'brand_id', 'code', 'title', 'description', 'price', 'discount', 'image_folder', 'cover_image', 'tags', 'status'
    ];

    public function variants()
    {
        return $this->hasMany('App\ProductVariant', 'product_id');
    }

    public function colors()
    {
        return $this->hasMany('App\ProductColor', 'product_id');
    }

    public function product_images()
    {
        return $this->hasMany('App\ProductImages', 'product_id');
    }
}
