<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $fillable = [
        'main', 'sub', 'url', 'title', 'tags'
    ];

    public function sub_categories()
    {
        return $this->hasMany('App\Category', 'main', 'id')->where(['sub' => 0]);
    }

    public function main_category()
    {
        return $this->belongsTo('App\Category', 'main', 'id');
    }
}
