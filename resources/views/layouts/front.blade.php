<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <!-- CSRF Token -->
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <title>{{ config('app.name', 'Laravel') }}</title>

        <!-- Scripts -->
        <!-- <script src="{{ asset('js/app.js') }}" defer></script> -->
    
        <!-- Fonts -->
        <link rel="dns-prefetch" href="//fonts.gstatic.com">
    
        <!-- Styles -->
        <link href="{{ asset('css/app.css') }}" rel="stylesheet">

        <style type="text/css">
            html,
            body,
            header,
            .carousel {
                height: 60vh;
            }

            @media (max-width: 740px) {

                    html,
                    body,
                    header,
                    .carousel {
                        height: 100vh;
                    }
                }

            @media (min-width: 800px) and (max-width: 850px) {

                html,
                body,
                header,
                .carousel {
                    height: 100vh;
                }
            }

        </style>
    </head>

    <body>
        <div id="app">
            @component('components.navbar')
            @endcomponent
            <!--Main layout-->
            <main>
                @yield('content')
            </main>
            <!--Main layout-->
            @component('components.footer')
            @endcomponent
        </div>
        <!-- Scripts -->
        <script src="{{ asset('js/app.js') }}" defer></script>
        <!-- Initializations -->
        <script type="text/javascript">
            // Animations initialization
            //new WOW().init();
            //window.hasCart = false;
        </script>
        <script>
            window.$cart = @json($cookie);
        </script>
    </body>

</html>