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
    return view('index');
})->name('index');

Auth::routes();

//Route::get('/home', 'HomeController@index')->name('home');
Route::get('/categories', 'HomeController@categories')->name('categories');
//User auth routes
Route::get('/logout', 'Auth\LoginController@userLogout')->name('user.logout');

//Admin routes
Route::group(['prefix' => 'admin'], function() {
    //Admin auth routes
    Route::match(['get', 'post'], '/login', 'Auth\AdminLoginController@login')->name('admin.login');
    Route::get('/logout', 'Auth\AdminLoginController@logout')->name('admin.logout');
    Route::get('/', 'AdminController@dashboard')->name('admin.dashboard')->middleware('role:admin|superadmin');
    Route::get('/manage-users', 'AdminController@users')->name('admin.users.manage')->middleware('role:superadmin|');
    Route::get('{path}', 'AdminController@dashboard')->where(['path', '([A-z\d-\/_.]+)?', 'path']);
});

//User protected routes
Route::group(['middleware' => 'auth'], function() {
    //User (Customer) routes
    Route::get('/home', 'HomeController@index')->name('home')->middleware('role:user|');
});