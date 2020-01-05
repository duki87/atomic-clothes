<?php

namespace App\Http\Middleware;

use Closure;
use Auth;

class SuperAdmin
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
        if(Auth::check() && Auth::user()->isSuperAdmin()) {
            return $next($request);
        }
        return redirect()->back()->with(['alert_message' => ['type' => 'danger', 'content' => 'You are not allowed to access this page! If you are superadmin, please login to access this page.']]);
    }
}
