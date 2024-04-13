<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/hello', function () {
    return "Hello from the Laravel!";
});

Route::get('/healthcheck', function () {
    return "Application is healthy!";
});