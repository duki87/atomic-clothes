<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Auth;

class AdminLoginController extends Controller
{

    public function __construct() 
    {
        $this->middleware('guest:admin', ['except' => ['logout']]);
    }

    public function login(Request $request)
    {
        if($request->isMethod('get')) {
            return view('auth.admin-login');
        }
        //Validate Form Data
        $this->validate($request, [
            'email'     => 'required|email',
            'password'  => 'required|min:6'
        ]);
        //Attempt to sign in
        //dd($request->isMethod('post'));
        $remember = $request->remember === null ? false : true;
        if(Auth::guard('admin')->attempt(['email' => $request->email, 'password' => $request->password], $remember)) {
            //If sign in is successful redirect to dashboard
            return redirect()->intended(route('admin.dashboard'));
        }
        //Else redirect back to login form
        return redirect()->back()->withInput($request->only('email', 'remember'));
    }   

    public function logout()
    {
        Auth::guard('admin')->logout(); 
        return redirect()->route('admin.login');
    }
}
