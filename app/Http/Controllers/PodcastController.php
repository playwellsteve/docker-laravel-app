<?php

namespace App\Http\Controllers;

use App\Jobs\ProcessPodcast;
use Illuminate\Http\Request;


class PodcastController extends Controller
{
    public function index()
    {
        ProcessPodcast::dispatch();
        return ['status' => 'ok'];
    }
}
