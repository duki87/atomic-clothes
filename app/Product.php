<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'main_category_id', 'sub_category_id', 'category_id', 'brand_id', 'code', 'title', 'description', 'price', 'discount', 'image_folder', 'cover_image', 'tags', 'status', 'url'
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

    public function main_category()
    {
        return $this->belongsTo('App\Category', 'main_category_id', 'id');
    }

    public function sub_category()
    {
        return $this->belongsTo('App\Category', 'sub_category_id', 'id');
    }

    public function category()
    {
        return $this->belongsTo('App\Category', 'category_id', 'id');
    }

    public function brand()
    {
        return $this->belongsTo('App\Brand', 'brand_id', 'id');
    }

    public function test()
    {
        return $this->hasManyThrough('App\ProductVariant', 'App\ProductColor');
    }
}
