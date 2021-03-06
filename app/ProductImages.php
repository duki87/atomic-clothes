<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductImages extends Model
{
    protected $fillable = [
        'product_id', 'color_id', 'image'
    ];

    public function product()
    {
        return $this->belongsTo('App\Product', 'product_id');
    }
}
