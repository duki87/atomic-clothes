<?php

namespace App\Http\Middleware;

use Closure;
use Auth;

class User
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
        if(Auth::check() && Auth::user()->isUser()) {
            return $next($request);
        }
        return redirect()->back()->with(['alert_message' => ['type' => 'danger', 'content' => 'Please login using your customer account.']]);
    }
}
