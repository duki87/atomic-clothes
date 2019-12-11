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

/* Route::group(['prefix' => 'admin'], function() {
    Route::apiResources([   
        'category' => 'API\CategoryController',     
    ]);
}); */

Route::apiResources([   
    'category' => 'API\CategoryController',       
    'brand' => 'API\BrandController',
    'product' => 'API\ProductController'
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
Route::post('validateProductImage', 'API\ProductController@validateProductImage');
