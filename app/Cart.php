<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cookie;
use App\PromoCode;
use App\CartItem;

class Cart extends Model
{
    protected $fillable = [
        'user_id', 'total', 'status', 'promo_code_id', 'discount'
    ];

    public function cart_items()
    {
        return $this->hasMany('App\CartItem', 'cart_id');
    }

    public function user()
    {
        return $this->hasOne('App\User', 'id', 'user_id');
    }
    
    public function promo_code()
    {
        return $this->hasOne('App\PromoCode', 'id', 'promo_code_id');
    }

    public static function get_cart()
    {
        if(Cookie::has('atomic_cart')) {
            $id = Cookie::get('atomic_cart');
            $cart = self::where(['id' => $id])->with(['cart_items' => function($query) {
                $query->orderBy('product_id', 'desc');
            }])
            ->with('promo_code')
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
        $cart = self::get_cart();
        $cartItemsToApplyDiscount = [];
        foreach($cart->cart_items as $cart_item) {
            if($coupon->brand_id && $coupon->category_id) {
                if($cart_item->product->brand_id === $coupon->brand_id && $cart_item->product->sub_category_id === $coupon->category_id) {
                    $cartItemsToApplyDiscount[] = $cart_item;
                }  
            } elseif($coupon->category_id) {
                if($cart_item->product->sub_category_id === $coupon->category_id) {
                    $cartItemsToApplyDiscount[] = $cart_item;
                }   
            } elseif($coupon->brand_id) {
                if($cart_item->product->brand_id === $coupon->brand_id) {
                    $cartItemsToApplyDiscount[] = $cart_item;
                }  
            } else {
                $cartItemsToApplyDiscount[] = $cart_item; 
            }
            //Check if coupon is for certain category of clothes
            // if($coupon->category_id) {
            //     if($cart_item->product->category_id === $coupon->category_id) {
            //         $cartItemsToApplyDiscount[] = $cart_item;
            //     }               
            // }
            // //Check if coupon is for certain brand of clothes
            // if($coupon->brand_id) {
            //     if($cart_item->product->brand_id === $coupon->brand_id) {
            //         $cartItemsToApplyDiscount[] = $cart_item;
            //     }  
            // }
            // if(!$coupon->brand_id && !$coupon->category_id) {
            //     $cartItemsToApplyDiscount[] = $cart_item; 
            // }
        }
        if($cartItemsToApplyDiscount) {
            foreach($cartItemsToApplyDiscount as $cart_item) {
                $price = $cart_item->product->discount ? $cart_item->product->discount : $cart_item->product->price;
                $discount = ($coupon->discount/100) * $price * $cart_item->quantity;
                $cart_item->discount = $discount;
                $cart_item->save();
                $cart->discount += $discount;
                $cart->promo_code_id = $coupon->id;
                $cart->save();
                $coupon->status = 0;
                $coupon->save();
            }
            return $cart;
        } else {
            return false;
        }
    }
}
