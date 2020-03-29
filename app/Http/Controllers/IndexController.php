<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;

class IndexController extends Controller
{
    public function index()
    {
        $cookie = isset($_COOKIE['atomic_cart']) ? true : false;         
        return view('front.index')->with(['cookie' => $cookie]);
    }
}
