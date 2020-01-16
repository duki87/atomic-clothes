<!--Navbar -->
<nav class="mb-1 navbar navbar-expand-lg navbar-dark default-color">
        <a class="navbar-brand" href="#">ATOMIC</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-333"
          aria-controls="navbarSupportedContent-333" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent-333">
          <ul class="navbar-nav mr-auto">

            @if(Auth::user()->isSuperAdmin())

            @endif
            <li class="nav-item">
              <router-link to="/admin/categories" class="nav-link" tag="a" class="nav-link" active-class="active" exact>Manage Categories</router-link>
            </li>
            <li class="nav-item">
              <router-link to="/admin/brands" class="nav-link" tag="a" class="nav-link" active-class="active" exact>Manage Brands</router-link>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false">Manage Products
              </a>
              <div class="dropdown-menu dropdown-default custom-navbar" aria-labelledby="navbarDropdownMenuLink-333">
                <router-link to="/admin/products" class="dropdown-item custom-dropdown-item" tag="a" active-class="custom-dropdown-item-active" exact>All Products</router-link>
                <router-link to="/admin/add-product" class="dropdown-item custom-dropdown-item" tag="a" active-class="custom-dropdown-item-active" exact>Add Product</router-link>
              </div>
            </li>
            <li class="nav-item">
              <router-link to="/admin/passport" class="nav-link" tag="a" class="nav-link" active-class="active" exact>Passport</router-link>
            </li>
          </ul>
          <ul class="navbar-nav ml-auto nav-flex-icons">
            <li class="nav-item">
              <a class="nav-link waves-effect waves-light">
                <i class="fab fa-twitter"></i>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link waves-effect waves-light">
                <i class="fab fa-google-plus-g"></i>
              </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false">
                {{Auth::user()->name}} <i class="fas fa-user"></i>
              </a>
              <div class="dropdown-menu dropdown-menu-right dropdown-default"
                aria-labelledby="navbarDropdownMenuLink-333">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <a class="dropdown-item" href="{{ route('logout') }}"
                onclick="event.preventDefault();
                              document.getElementById('logout-form').submit();">
                 {{ __('Logout') }}
                </a>
                <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                  @csrf
                </form>
              </div>
            </li>
          </ul>
        </div>
      </nav>
      <!--/.Navbar -->