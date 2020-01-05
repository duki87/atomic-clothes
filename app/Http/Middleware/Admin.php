<?php

namespace App\Http\Middleware;

use Closure;
use Auth;

class Admin
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        if(Auth::check() && Auth::user()->isAdmin()) {
            return $next($request);
        }
        return redirect()->back()->with(['alert_message' => ['type' => 'danger', 'content' => 'You are not allowed to access this page! If you have admin account, please login as admin to access this page.']]);
    }
}
