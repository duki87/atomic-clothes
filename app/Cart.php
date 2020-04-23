<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cookie;
use App\PromoCode;

class Cart extends Model
{
    protected $fillable = [
        'user_id', 'total', 'status'
    ];

    public function cart_items()
    {
        return $this->hasMany('App\CartItem', 'cart_id');
    }

    public function user()
    {
        return $this->hasOne('App\User', 'id', 'user_id');
    }

    public static function get_cart()
    {
        if(Cookie::has('atomic_cart')) {
            $id = Cookie::get('atomic_cart');
            $cart = self::where(['id' => $id])->with(['cart_items' => function($query) {
                $query->orderBy('product_id', 'desc');
            }])
            ->with('cart_items.product')  
            ->with('cart_items.variant')    
            ->with('cart_items.variant.variant_color')            
            ->with('cart_items.variant.variant_color.color_variant_images')
            ->first();
            return $cart;
        } 
        return false;
    }

    public static function apply_discount_to_cart(PromoCode $coupon)
    {
        //UPDATE: CART: PROMO_CODE_ID, DISCOUNT; FOR EVERY CART ITEM DISCOUNT 
        $cart = self::get_cart();
        //Check if coupon is for certain category of clothes
        if($coupon->category_id) {

        }
        //Check if coupon is for certain brand of clothes
        if($coupon->brand_id) {

        }

    }
}
