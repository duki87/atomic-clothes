<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;
use App\Product;
use App\ProductVariant;
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
            ->with('cart_items.variant.variant_color')            
            ->with('cart_items.variant.variant_color.color_variant_images')
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
        $cart = Cart::where(['id' => $id])
        ->with('cart_items')
        ->with('cart_items.product')  
        ->with('cart_items.variant')    
        ->first();
        foreach($cart->cart_items as $item) {
            $this->increase_stock_quantity($item->quantity, $item->variant);
            $item->delete();
        } 
        $cart->delete();
        return response('Cart deleted');
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
                $validator = Validator::make([], []); 
                $validator->errors()->add('cart', 'Error creating new cart');
                throw new ValidationException($validator);
            }
        }     
        //Search if cart item already exist
        $cart_item = CartItem::where([
            'cart_id'    => $cart->id, 
            'product_id' => $request->product_id,
            'variant_id' => $request->variant_id
        ])->with('product')->with('variant')->first();
        if($cart_item) {
            $product = $cart_item->product;
            $quantity = $cart_item->quantity + $request->quantity;
            $price = $product->discount ? $product->discount : $product->price;
            $cart_item->quantity = $quantity;
            $cart_item->subtotal += $quantity * $price;
            if($cart_item->save()) {
                $cart->increment('total', $quantity * $price);
                if(!$this->decrease_stock_quantity($request->quantity, $cart_item->variant)) {
                    $validator = Validator::make([], []); // Empty data and rules fields
                    $validator->errors()->add('cart', 'Not enough items on stock');
                    throw new ValidationException($validator);
                }
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
            if(!$this->decrease_stock_quantity($request->quantity, ProductVariant::where(['id' => $request->variant_id])->first())) {
                $validator = Validator::make([], []); // Empty data and rules fields
                $validator->errors()->add('cart', 'Not enough items on stock');
                throw new ValidationException($validator);
            }
            if($cartItem->save()) {
                $cart->increment('total', $cartItem->subtotal);
                if($cart->save()) {
                    return response('New Cart Item', 201)
                    ->cookie('atomic_cart', $cart_id, 24*60);
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

    public function increase($item_id)
    {
        $cart_item = CartItem::where(['id' => $item_id])
        ->with('cart')
        ->with('product')
        ->with('variant')
        ->first();
        if(!$this->decrease_stock_quantity(1, $cart_item->variant)) {
            $validator = Validator::make([], []); // Empty data and rules fields
            $validator->errors()->add('cart', 'Not enough items on stock');
            throw new ValidationException($validator);
        }
        $price = $cart_item->product->discount ? $cart_item->product->discount : $cart_item->product->price;
        $cart_item->quantity += 1;
        $cart_item->subtotal += $price;
        $cart_item->cart->total += $price;
        if($cart_item->save()) {
            $cart_item->cart->save();
            return response('Cart item quantity increased');
        }     
    }

    public function decrease($item_id)
    {
        $cart_item = CartItem::where(['id' => $item_id])
        ->with('cart')
        ->with('product')
        ->with('variant')
        ->first();
        $this->increase_stock_quantity(1, $cart_item->variant);
        $price = $cart_item->product->discount ? $cart_item->product->discount : $cart_item->product->price;
        $cart_item->quantity -= 1;
        $cart_item->subtotal -= $price;
        $cart_item->cart->total -= $price;
        if($cart_item->save()) {
            $cart_item->cart->save();
            return response('Cart item quantity decreased');
        }  
    }

    public function delete_item($item_id)
    {
        $cart_item = CartItem::where(['id' => $item_id])
        ->with('cart')
        ->with('product')
        ->with('variant')
        ->first();
        $this->increase_stock_quantity($cart_item->quantity, $cart_item->variant);
        $cart_item->cart->total -= $cart_item->subtotal;
        if($cart_item->cart->save()) {
            $cart_item->delete();
            return response('Cart item deleted');
        } 
    }

    private function decrease_stock_quantity($quantity, ProductVariant $variant)
    {
        if($quantity > $variant->stock) {
            return false;
        }
        $variant->stock -= $quantity;
        if($variant->save()) {
            return true;
        }
    }

    private function increase_stock_quantity($quantity, ProductVariant $variant)
    {
        $variant->stock += $quantity;
        if($variant->save()) {
            return true;
        }
    }
}
