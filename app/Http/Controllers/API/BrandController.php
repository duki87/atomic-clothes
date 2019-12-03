<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Brand;
use App\Traits\ImagesTrait;
use App\Traits\ManualPaginationTrait;

class BrandController extends Controller
{
    use ImagesTrait, ManualPaginationTrait;

    public function __construct()
    {
      //$this->middleware('auth:api');
    }

    public function index()
    {
        //if(Gate::allows('isAdmin') || Gate::allows('isAuthor')) {
            $brands = Brand::orderBy('created_at', 'desc')->get();                  
            $brands->transform(function($brand) {
                $brand->tags = $brand->tags ? json_decode($brand->tags) : [];
                return $brand;
            });
            $brands = self::paginate($brands, $brands->count(), 5);
            return ['brands' => $brands];
        //}
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'title' => 'required|string|min:2',
            'description' => 'string|min:20',
            'website' => 'url',
        ]); 
        if($request->has('logo') && !empty($request->logo)) {
            $logo = self::uploadConstraintImage($request->logo, 300, 'png', 'brandLogos');
        }
        $brand = new Brand([
            'title' => $request->title,
            'description' => $request->description,
            'logo' => isset($logo) ? $logo : '',
            'website'  =>  $request->website,
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : ''
        ]);
        if($brand->save()) {
            return ['message' => 'success'];
        }
        return ['message' => 'failed']; 
    }

    public function show($id)
    {
        //
    }

    public function update(Request $request, $id)
    {      
        $brand = Brand::where(['id' => $id])->first();
        $this->validate($request, [
            'title' => 'required|string|min:2',
            'description' => 'string|min:20',
            'website' => 'url|sometimes',
        ]); 
        if($request->has('logo') && $brand->logo != $request->logo) {
            self::deleteImage('brandLogos', $brand->logo);
            $logo = self::uploadConstraintImage($request->logo, 300, 'png', 'images/brandLogos');
        }
        $update = $brand->update([
            'title' => $request->title,
            'description' => $request->description,
            'logo' => isset($logo) ? $logo : $brand->logo,
            'website'  =>  $request->website,
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : ''
        ]);
        if($update) {
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function destroy($id)
    {
        $brand = Brand::where(['id' => $id])->first();
        $logo = $brand->logo;
        if($logo != '') {
            self::deleteImage('brandLogos', $logo);
        }    
        if($brand->delete()) {
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function destroyLogo($id)
    {
        $brand = Brand::where(['id' => $id])->first();
        $logo = $brand->logo;
        if($logo != '') {
            if(self::deleteImage('brandLogos', $logo)) {
                $brand->update([
                    'logo' => ''
                ]);
                return ['message' => 'success'];
            }         
        }
        return ['message' => 'failed'];    
    }
    public function destroyAll() 
    {
        $logos = Brand::get()->pluck('logo');
        $deleteLogos = $logos->each(function ($item, $key) {
            self::deleteImage('brandLogos', $item);
        });
        if($deleteLogos) {
            if(Brand::truncate()) {
                return ['message' => 'success'];
            } 
        }
        return ['message' => 'failed'];
    }

    public function loadBrands()
    {
        $brands = Brand::orderBy('created_at', 'desc')->pluck('id', 'title')->all();                 
        return ['brands' => $brands];
    }
}
