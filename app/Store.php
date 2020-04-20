<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Store extends Model
{
    protected $fillable = [
        'title', 'city', 'address', 'phone', 'latitude', 'longitude', 'manager', 'image'
    ];
}
