<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Category;
use App\Traits\ManualPaginationTrait;

class CategoryController extends Controller
{
    use ManualPaginationTrait;

    public function __construct()
    {
      //$this->middleware('auth:api');
    }

    public function index()
    {      
        //if(Gate::allows('isAdmin') || Gate::allows('isAuthor')) {
            $mains = Category::where(['main' => 0])->get();
            $categories = Category::orderBy('created_at', 'desc')->get();                  
            $categories->transform(function($category) {
                $category->mainTitle = $category->main == 0 ? '/' : Category::where(['id' => $category->main])->first()['title'];
                $category->subTitle = $category->sub == 0 ? '/' : Category::where(['id' => $category->sub])->first()['title'];
                $category->tags = $category->tags ? json_decode($category->tags) : [];
                return $category;
            });
            $categories = self::paginate($categories, $categories->count(), 5);
            return ['mains' => $mains, 'categories' => $categories];
        //}
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'title' => 'required|string|min:3',
            'main' => 'required|integer',
            'sub' => 'required|integer',
        ]);
        $category = new Category([
            'title' => $request->title,
            'main'  =>  $request->main,
            'sub'  =>  $request->sub,
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : ''
        ]);
        if($category->save()) {
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
        $category = Category::where(['id' => $id])->first();
        $this->validate($request, [
            'title' => 'required|string|min:3',
            'main' => 'required|integer',
            'sub' => 'required|integer',
        ]);
        $update = $category->update([
            'title' => $request->title,
            'main'  =>  $request->main,
            'sub'  =>  $request->sub,
            'tags'  =>  !empty($request->tags) ? json_encode($request->tags) : ''
        ]);
        if($update) {
            return ['message' => 'success'];
        }
        return ['message' => 'failed'];
    }

    public function destroy($id)
    {
        $category = Category::where(['id' => $id])->first();
        if($category->sub == 0) {
            Category::where('sub', '=', $id)->delete();
        }
        if($category->main == 0) {
            Category::where('main', '=', $id)->delete();
        }
        $category->delete();
    }

    public function destroyAll()
    {
        if(Category::truncate()) {
            return ['message' => 'success'];
        }           
        return ['message' => 'failed'];
    }
    
    public function load_subs($main_id)
    {       
        $subs = Category::where([
                ['main', '=', $main_id],
                ['sub', '=', 0],
            ])->get();
        return ['subCategories' => $subs];
    }
}
