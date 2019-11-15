<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Category;

class CategoryController extends Controller
{

    public function __construct()
    {
      //$this->middleware('auth:api');
    }

    public function index()
    {      
        //if(Gate::allows('isAdmin') || Gate::allows('isAuthor')) {
            $mains = Category::where(['main' => 0])->get();
            $categories = Category::orderBy('created_at', 'desc')->paginate(2);
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
        //
    }

    public function destroy($id)
    {
        Category::where(['id' => $id])->delete();
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
