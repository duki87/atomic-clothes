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
    'brand' => 'API\BrandController'
]);

//Other category routes
Route::get('loadSubCategories/{mainId}', 'API\CategoryController@load_subs');
Route::get('destroyCategories', 'API\CategoryController@destroyAll');

//Other brand routes
Route::post('uploadBrandLogo', 'API\ImageController@uploadBrandLogo');
Route::post('validateImage', 'API\BrandController@validateImage');