<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Passport\HasApiTokens;

class User extends Authenticatable
{
    use Notifiable, HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'username', 'role', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function isSuperAdmin()
    {
        return $this->role == 'superadmin';
    }

    public function isUser()
    {
        return $this->role == 'user';
    }

    public function isAdmin()
    {
        return ($this->role == 'superadmin' || $this->role == 'admin');
    }

    public function hasRole($role)
    {
        return $this->role == $role;
    }

    public function hasAnyRole($roles)
    {
        if(is_array($roles)) {
            $pass = [];
            foreach($roles as $role) {
                if($this->hasRole($role)) {
                    $pass[] = true;
                }
            }
            return count($pass)>0 ? true : false;
        } else {
            if($this->hasRole($roles)) {
                return true;
            }
        }
        return false;
    }
}
