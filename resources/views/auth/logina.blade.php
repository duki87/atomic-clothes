@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">

        <div class="col-md-8">
            <!-- Default form login -->
            <form class="needs-validation text-center border border-light p-5" method="POST" action="{{ route('login') }}">
                @csrf
                <p class="h4 mb-4">Sign in</p>
                <div class="">
                    <input id="email" type="email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>
                    <div class="valid-feedback">
                      Looks good!
                    </div>
                    @error('email')
                        <div class="invalid-feedback">
                            {{ $message }}
                        </div>
                    @enderror
                </div>

                <div class="mt-2">
                    <input id="password" type="password" class="form-control @error('password') is-invalid @enderror" name="password" required autocomplete="current-password">
                    <div class="valid-feedback">
                      Looks good!
                    </div>
                    @error('password')
                        <div class="invalid-feedback">
                            {{ $message }}
                        </div>
                    @enderror
                </div>

                <div class="mt-2 d-flex justify-content-around">
                    <div>
                        <!-- Remember me -->
                        <div class="custom-control custom-checkbox form-check">
                            <input class="form-check-input" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>
                            <label class="custom-control-label" for="remember">Remember me</label>
                        </div>
                    </div>
                    <div class="">
                        <!-- Forgot password -->
                        @if (Route::has('password.request'))
                            <a href="{{ route('password.request') }}">Forgot password?</a>
                        @endif
                    </div>
                </div>

                <!-- Sign in button -->
                <button class="btn btn-info btn-block my-4" type="submit">Sign in</button>

                <!-- Register -->
                <p>Not a member?
                    <a href="">Register</a>
                </p>

                <!-- Social login -->
                <p>or sign in with:</p>

                <a href="#" class="mx-2" role="button"><i class="fab fa-facebook-f light-blue-text"></i></a>
                <a href="#" class="mx-2" role="button"><i class="fab fa-twitter light-blue-text"></i></a>
                <a href="#" class="mx-2" role="button"><i class="fab fa-linkedin-in light-blue-text"></i></a>
                <a href="#" class="mx-2" role="button"><i class="fab fa-github light-blue-text"></i></a>

            </form>
            <!-- Default form login -->
        </div>
    </div>
</div>
@endsection
