<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['middleware' => 'auth:api'], function() { 
    Route::apiResources([   
        'category'    => 'API\CategoryController',       
        'brand'       => 'API\BrandController',
        'product'     => 'API\ProductController',
        'variant'     => 'API\ProductVariantController',
        'color'       =>  'API\ProductColorController',
        'promo-codes' => 'API\PromoCodeController',
        'store'       => 'API\StoreController',
    ]);
    
    //Other category routes
    Route::get('loadSubCategories/{mainId}', 'API\CategoryController@load_subs'); //after applying loadCategories route for categories component, delete this
    Route::get('loadCategories/{type}/{id}', 'API\CategoryController@loadCategories');
    Route::get('destroyCategories', 'API\CategoryController@destroyAll');
    Route::get('loadAllCategories', 'API\CategoryController@loadAllCategories');
    
    //Other brand routes
    Route::get('destroyBrandLogo/{id}', 'API\BrandController@destroyLogo');
    Route::post('validateLogoImage', 'API\BrandController@validateBrandLogo');
    Route::get('destroyBrands', 'API\BrandController@destroyAll');
    Route::get('loadBrands', 'API\BrandController@loadBrands');
    
    //Other product routes
    Route::post('uploadProductImages', 'API\ProductController@uploadProductImages');
    Route::get('loadProduct/{id}', 'API\ProductController@loadProduct');
    Route::get('destroyProductImage/{id}', 'API\ProductController@destroyProductImage');
    Route::get('destroyProductImages/{id}', 'API\ProductController@destroyProductImages');

    //Other variant routes
    Route::get('getVariantsByProductId/{product_id}', 'API\ProductVariantController@getVariantsByProductId');

    //Other colors routes
    Route::get('getProductColorVariants/{product_id}', 'API\ProductColorController@getProductColorVariants');

    //Other store routes
    Route::post('validateStoreImage', 'API\BrandController@validateStoreImage');
});

//Front routes
Route::apiResources([   
    'cart'  => 'API\CartController',
]);
Route::get('getCollection/{collection}', 'API\FrontController@getCollection');
Route::get('getProducts/{collection}/{category}/{filters?}', 'API\FrontController@getProducts');
Route::get('getProduct/{product}', 'API\FrontController@getProduct');

Route::get('cookieExist', 'API\CartController@cookie_exist');
Route::post('addToCart', 'API\CartController@add_to_cart');
Route::get('cart/increase/{item_id}', 'API\CartController@increase');
Route::get('cart/decrease/{item_id}', 'API\CartController@decrease');
Route::get('cart/deleteItem/{item_id}', 'API\CartController@delete_item');