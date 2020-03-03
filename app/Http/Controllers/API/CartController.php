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
            //$cart = Cart::where(['id' => $cart_id])->with('cart_items')->first();
            $cart = Cart::where(['id' => $cart_id])->with(['cart_items' => function($query) {
                $query->orderBy('product_id', 'desc');
            }])
            ->with('cart_items.product')  
            ->with('cart_items.variant')                
            ->first();
            return response(['cart' => $cart], 200);
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
        $this->validate($request, [
            'product_id' => 'required|integer',
            'variant_id' => 'required|integer',
        ]);
        $cart_id;
        $cart;
        //Check if cart cookie exist and find cart
        if(Cookie::has('atomic_cart')) {
            $cart_id = Cookie::get('atomic_cart');
            $cart = Cart::where(['id' => $cart_id])->first();
        } else {
            //Create a new cart
            $cart = new Cart([
                'user_id' => Auth::check() ? Auth::id() : 0,
                'total'  =>  0
            ]);
            if($cart->save()) {
                $cart_id = $cart->id;             
            } else {
                $validator = Validator::make([], []); // Empty data and rules fields
                $validator->errors()->add('cart', 'Error creating new cart');
                throw new ValidationException($validator);
            }
        }     
        //Search if cart item already exist
        $cart_item = CartItem::where([
            'cart_id'    => $cart->id, 
            'product_id' => $request->product_id,
            'variant_id' => $request->variant_id
        ])->with('product')->first();
        if($cart_item) {
            $product = $cart_item->product;
            $quantity = $cart_item->quantity + $request->quantity;
            $price = $product->discount ? $product->discount : $product->price;
            $cart_item->quantity = $quantity;
            $cart_item->subtotal += $quantity * $price;
            if($cart_item->save()) {
                $cart->increment('total', $quantity * $price);
                if($cart->save()) {
                    return response('Cart updated', 201)
                    ->cookie('atomic_cart', $cart->id, 60*60);
                }           
            }
        } else {
            //Create new cart item
            $product = Product::where(['id' => $request->product_id])->first();  
            $price = $product->discount ? $product->discount : $product->price;
            $cartItem = new CartItem([
                'cart_id'       => $cart_id,
                'product_id'    => $request->product_id,
                'variant_id'    => $request->variant_id,
                'product_price' => $price,
                'quantity'      => $request->quantity,
                'subtotal'      => $request->quantity * $price
            ]);
            if($cartItem->save()) {
                $cart->increment('total', $cartItem->subtotal);
                if($cart->save()) {
                    return response('New Cart Item', 201)
                    ->cookie('atomic_cart', $cart_id, 60*60);
                }
            }
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
}
