<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DiceType extends Model
{
    public $timestamps = false;
    protected $fillable = ['name', 'sides'];
}
