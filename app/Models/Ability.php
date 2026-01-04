<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ability extends Model
{
    public $timestamps = false;
    
    protected $fillable = ['name', 'abbreviation', 'description'];
}
