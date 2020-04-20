@extends('layouts.admin')

@section('content')
<div class="container">
    <router-view :key="$route.fullPath"></router-view>
    <vue-progress-bar></vue-progress-bar>
</div>
@endsection
