<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

//Route::get('/home', 'HomeController@index')->name('home');
Route::get('/categories', 'HomeController@categories')->name('categories');

Route::group(['middleware' => 'auth'], function() {
    //User (Customer) routes
    Route::get('/home', 'HomeController@index')->name('home')->middleware('role:user|');
    //Admin routes
    Route::group(['prefix' => 'admin'], function() {
        Route::get('/', 'AdminController@dashboard')->name('admin.dashboard')->middleware('role:admin|superadmin');
        Route::get('/manage-users', 'AdminController@users')->name('admin.users.manage')->middleware('role:superadmin|');
        Route::get('{path}', 'AdminController@dashboard')->where(['path', '([A-z\d-\/_.]+)?', 'path']);
        //Route::get('/{path}', 'AdminController@dashboard')->where(['path', '([A-z\d-\/_.]+)?', 'path']);
/*         Route::get('/{any}', 'AdminController@index')->where('any', '.*')->middleware('role:admin|superadmin');
        Route::get('/dashboard', 'AdminController@index')->name('admin.dashboard')->middleware('role:admin|superadmin');
        Route::get('/manage-users', 'AdminController@users')->name('admin.users.manage')->middleware('role:superadmin|'); */
/*         Route::get('/', function() {
            return redirect('admin/dashboard');
        });
        Route::get('/dashboard', 'AdminController@dashboard')->name('admin.dashboard')->middleware('role:admin|superadmin');
        Route::get('/manage-users', 'AdminController@users')->name('admin.users.manage')->middleware('role:superadmin|');
        Route::get('/{path}', 'AdminController@dashboard')->where(['path', '([A-z\d-\/_.]+)?', 'path']); */
    });
});