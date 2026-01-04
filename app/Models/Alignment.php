<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Alignment extends Model
{
    public $timestamps = false;
    
    protected $fillable = ['name'];
}
