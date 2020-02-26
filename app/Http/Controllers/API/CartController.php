<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;
use App\Product;
use App\Cart;
use App\CartItem;
use Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class CartController extends Controller
{
    public function index()
    {
        if(Cookie::has('atomic_cart')) {
            $cart_id = Cookie::get('atomic_cart');
            $cart = Cart::where(['id' => $cart_id])->first();
            return ['cart' => $cart];
        } 
        $validator = Validator::make([], []); // Empty data and rules fields
        $validator->errors()->add('cart', 'NOT_FOUND');
        throw new ValidationException($validator);
    }

    public function show($id)
    {
        if(Cookie::has('atomic_cart')) {
            $cookie = Cookie::get('atomic_cart');
        } 
    }

    public function store(Request $request)
    {
        
    }

    public function destroy($id)
    {
        
    }

    public function add_to_cart(Request $request)
    {
        //Check if cart cookie exist and find cart
        if(Cookie::has('atomic_cart')) {
            $cart_id = Cookie::get('atomic_cart');        
            $cart = Cart::where(['id' => $cart_id])
            ->whereHas('cart_items', function($q) {
                $q->where(['cart_id' => $cart_id, 'product_id' => $request->product_id]);
            })
            ->first();
            //Search if cart item already exist
            //$cartItem = Cart::where(['cart_id' => $cart_id, 'product_id' => $request->product_id])->first();
        } else {
            //Create new cart
            $cart = new Cart([
                'user_id' => Auth::check() ? Auth::id() : 0,
                'total'  =>  0
            ]);
            if($cart->save()) {
                $cart_id = $cart->id;             
            } else {
                $validator = Validator::make([], []); // Empty data and rules fields
                $validator->errors()->add('cart', 'NOT_CREATED');
                throw new ValidationException($validator);
            }           
        }
        //Create new cart item
        $cartItem = new CartItem([
            'cart_id' => $cart_id,
            'product_id' => $request->product_id,
            'product_price' => $request->product_price,
            'quantity' => $request->quantity,
            'subtotal' => $request->subtotal
        ]);
        if($cartItem->save()) {
            $cart_cookie = Cookie::make('atomic_cart', $cart_id, 3600);
            return ['message' => $cart_cookie];
        }             
    }

    public function cookie_exist()
    {
        if(Cookie::has('atomic_cart')) {
            return ['cookie' => true];
        } 
        $validator = Validator::make([], []); // Empty data and rules fields
        $validator->errors()->add('cart', 'NOT_FOUND');
        throw new ValidationException($validator);
    }

    /*
    Set cookie: Cookie::queue(Cookie::make('cookieName', 'value', $minutes));

Get cookie: $value = $request->cookie('cookieName'); or $value = Cookie::get('cookieName');

Forget/remove cookie: Cookie::queue(Cookie::forget('cookieName'));

Check if cookie exist: Cookie::has('cookiename'); or $request->hasCookie('cookiename') will return true or false
    */
}
