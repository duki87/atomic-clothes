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
            $logo = self::uploadBrandLogo($request->logo);
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
        //
    }

    public function destroy($id)
    {
        //
    }
}
