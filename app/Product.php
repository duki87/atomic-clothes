<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'category_id', 'brand_id', 'title', 'description', 'image_folder', 'cover_image', 'tags', 'url'
    ];
}
