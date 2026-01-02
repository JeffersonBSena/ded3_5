<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Campaign extends Model
{
    protected $fillable = [
        'user_id',
        'title',
        'description',
        'image_path',
        'status',
        'max_players',
        'rules',
    ];

    protected $casts = [
        'rules' => 'array',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function users()
    {
        return $this->belongsToMany(User::class, 'campaign_users')
            ->withPivot(['status', 'character_id'])
            ->withTimestamps();
    }

    public function enrollments()
    {
        return $this->hasMany(CampaignUser::class);
    }
}
