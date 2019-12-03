<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'main_category_id', 'sub_category_id', 'category_id', 'brand_id', 'title', 'description', 'price', 'discount', 'image_folder', 'cover_image', 'tags'
    ];

    public function variants()
    {
        return $this->hasMany('App\ProductVariant', 'product_id');
    }
}
