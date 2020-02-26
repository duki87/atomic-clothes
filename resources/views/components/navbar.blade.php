    <!-- Navbar -->
    <nav class="navbar fixed-top navbar-expand-lg navbar-light white scrolling-navbar">
        <div class="container">

            <!-- Brand -->
            <a class="navbar-brand waves-effect" href="https://mdbootstrap.com/docs/jquery/" target="_blank">
            <strong class="blue-text">ATOMIC</strong>
            </a>

            <!-- Collapse -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Links -->
            <div class="collapse navbar-collapse" id="navbarSupportedContent">

            <!-- Left -->
            <ul class="navbar-nav mr-auto">
                <li class="nav-item" :class="{ 'active': $route.name === 'index' }">
                    <router-link to="/" class="nav-link waves-effect" tag="a" active-class="active" exact>
                        Home
                    </router-link>
                </li>
                <li class="nav-item" :class="{ 'active': $route.path === '/collections/men' }">
                    <router-link :to="{ name: 'collections', params: { collection: 'men' }}" class="nav-link waves-effect" tag="a" active-class="active" exact>
                        For Men
                    </router-link>
                </li>
                <li class="nav-item" :class="{ 'active': $route.path === '/collections/women' }">
                    <router-link :to="{ name: 'collections', params: { collection: 'women' }}" class="nav-link waves-effect" tag="a" active-class="active" exact>
                        For Women
                    </router-link>
                </li>
                <li class="nav-item" :class="{ 'active': $route.path === '/collections/children' }">
                    <router-link :to="{ name: 'collections', params: { collection: 'children' }}" class="nav-link waves-effect" tag="a" active-class="active" exact>
                        Children
                    </router-link>
                </li>
                <li class="nav-item" :class="{ 'active': $route.name === 'stores' }">
                    <router-link to="/stores" class="nav-link waves-effect" tag="a" active-class="active" exact>
                        Stores
                    </router-link>
                </li>
            </ul>

            <!-- Right -->
            <ul class="navbar-nav nav-flex-icons">
                @if(Cookie::has('atomic-cart'))
                <li class="nav-item">
                    <a class="nav-link waves-effect">
                        <span class="badge red z-depth-1 mr-1"> 1 </span>
                        <i class="fas fa-shopping-cart"></i>
                        <span class="clearfix d-none d-sm-inline-block"> Cart </span>
                    </a>
                </li>
                @endif
                <li class="nav-item">
                    <a href="https://www.facebook.com/mdbootstrap" class="nav-link waves-effect">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="https://twitter.com/MDBootstrap" class="nav-link waves-effect">
                        <i class="fab fa-google"></i>
                    </a>
                </li>
                @guest
                <li class="nav-item">
                    <a href="{{ route('login') }}" class="nav-link border border-light rounded waves-effect">
                        <i class="fas fa-sign-in-alt"></i>Sign In
                    </a>
                </li>
                @endguest
                @auth
                    @if(Auth::user()->isAdmin() == false)
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">{{Auth::user()->name}}
                        </a>
                        <div class="dropdown-menu dropdown-default" aria-labelledby="navbarDropdownMenuLink-333">
                            <a class="dropdown-item" href="#">Profile</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <a class="dropdown-item" href="{{ route('logout') }}"
                            onclick="event.preventDefault();
                                        document.getElementById('logout-form').submit();">
                            {{ __('Logout') }}
                            </a>
                            <form id="logout-form" action="{{ route('user.logout') }}" method="GET" style="display: none;">
                            @csrf
                            </form>
                        </div>
                    </li>
                    @else
                        <li class="nav-item">
                            <a href="{{ route('login') }}" class="nav-link border border-light rounded waves-effect">
                                <i class="fas fa-sign-in-alt"></i>Sign In
                            </a>
                        </li>
                    @endif
                @endauth
            </ul>

            </div>

        </div>
    </nav>
    <!-- Navbar -->