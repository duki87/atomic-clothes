<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Store extends Model
{
    protected $fillable = [
        'title', 'city', 'address', 'phone', 'latitude', 'longitude', 'manager', 'image'
    ];

    public function store_stocks()
    {
        return $this->hasMany('App\StoreStock', 'store_id');
    }

}
