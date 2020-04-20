<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Traits\ManualPaginationTrait;
use App\Traits\ImagesTrait;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;
use App\Store;

class StoreController extends Controller
{
    use ImagesTrait, ManualPaginationTrait;

    public function __construct()
    {
      //$this->middleware('auth:api');
    }

    public function index()
    {
        $stores = Store::get();
        return response(['stores' => $stores], 200);
    }

    public function store(Request $request) 
    {
        $this->validate($request, [
            'title' => 'required|string|min:5',
            'address' => 'required|string|min:5',
            'city' => 'required|string|min:3',
            'phone' => 'required|regex:/(01)[0-9]{9}/',
            'manager' => 'required|string|min:5', 
            'image' => 'required',
            'latitude' => 'required|regex:/^-?\d{1,3}\.\d{6,}$/', 
            'longitude' => 'required|regex:/^-?\d{1,3}\.\d{6,}$/', 
        ]);
        if($request->has('image') && !empty($request->image)) {
            $image = self::uploadConstraintImage($request->image, 300, 'png', 'stores');
        }
        $store = new Store([
            'title' => $request->title,
            'address' => $request->address,
            'city' => $request->city,
            'phone'  =>  $request->phone,
            'manager'  =>  $request->manager,
            'image' => $image,
            'latitude'  =>  $request->latitude,
            'longitude'  =>  $request->longitude,
        ]);
        if($store->save()) {
            return response('Store saved.', 201);
        }
        return response('Error saving store.', 500); 
    }

    public function show($id) 
    {

    }

    public function destroy($id) 
    {

    }
}
