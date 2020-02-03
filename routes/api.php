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
        'category' => 'API\CategoryController',       
        'brand' => 'API\BrandController',
        'product' => 'API\ProductController',
        'variant' => 'API\ProductVariantController',
    ]);
    
    //Other category routes
    Route::get('loadSubCategories/{mainId}', 'API\CategoryController@load_subs'); //after applying loadCategories route for categories component, delete this
    Route::get('loadCategories/{type}/{id}', 'API\CategoryController@loadCategories');
    Route::get('destroyCategories', 'API\CategoryController@destroyAll');
    
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
});

