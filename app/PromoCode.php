<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PromoCode extends Model
{
    protected $fillable = [
        'user_id', 'category_id', 'brand_id', 'coupon_series', 'coupon_no', 'discount', 'start', 'expire', 'status'
    ];
}
