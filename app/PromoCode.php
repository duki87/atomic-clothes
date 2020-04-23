<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PromoCode extends Model
{
    protected $fillable = [
        'user_id', 'category_id', 'brand_id', 'coupon_series', 'coupon_no', 'discount', 'start', 'expire', 'status'
    ];

    public function find($coupon_no, $coupon_series) 
    {
        return $this->where(['coupon_series' => $coupon_series, 'coupon_no' => $coupon_no])->first();
    }
}
