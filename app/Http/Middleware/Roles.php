<?php

namespace App\Http\Middleware;

use Closure;
use Auth;

class Roles
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next, $roles)
    {   
        $roles = explode('|', $roles);
        //dd($roles);
        if($request->user() === null) {
            return redirect('/login');
        }

        if($request->user()->hasAnyRole($roles)) {
            return $next($request);
        }
        
        return redirect()->back()->with(['alert_message' => ['type' => 'danger', 'content' => 'You are not allowed to access this page!']]);
    }

}
