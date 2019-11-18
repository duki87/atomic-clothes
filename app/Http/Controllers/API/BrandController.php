<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Brand;
use App\Traits\ManualPaginationTrait;

class BrandController extends Controller
{
    public function __construct()
    {
      //$this->middleware('auth:api');
    }

    public function index()
    {
        //
    }

    public function store(Request $request)
    {
        //
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
