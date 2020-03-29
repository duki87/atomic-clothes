/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */
import {
  MglMap,
  MglMarker,
  MglGeojsonLayer
} from 'vue-mapbox';
import bsCustomFileInput from 'mdbootstrap/js/modules/bs-custom-file-input';
//import mdbRate from 'mdbootstrap/js/addons/rating';
import VueRouter from 'vue-router';
import { Form, HasError, AlertError } from 'vform';
import moment from 'moment';
import VueProgressBar from 'vue-progressbar';
import Swal from 'sweetalert2';
import VueDraggable from 'vue-draggable';
import routes from './routes';
import VueWow from 'vue-wow';
 
require('./bootstrap');

global.bsCustomFileInput = bsCustomFileInput;
//global.mdbRate = mdbRate;

window.Vue = require('vue');
window.Form = Form;

//Mount wow js
Vue.use(VueWow);

//Router setup
Vue.use(VueRouter);

const router = new VueRouter({
    mode: 'history',
    routes
});

//Vue Draggable Setup
Vue.use(VueDraggable);

//sweetalert setup
window.Swal = Swal;
const Toast = Swal.mixin({
  toast: true,
  position: 'top-end',
  showConfirmButton: false,
  timer: 3000
});
window.Toast = Toast;

//Global variable $cart which determines whether cart is set or not
window.$cart;

//new instance of Vue to create custom events
window.Fire = new Vue();

//form errors setup
Vue.component(HasError.name, HasError);
Vue.component(AlertError.name, AlertError);

//progressbar setup
const options = {
    color: '#bffaf3',
    failedColor: '#874b4b',
    thickness: '5px',
    transition: {
      speed: '0.2s',
      opacity: '0.6s',
      termination: 300
    },
    autoRevert: true,
    location: 'top',
    inverse: false
  }
  Vue.use(VueProgressBar, options);
/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

//Components
Vue.component('example-component', require('./components/admin/ExampleComponent.vue').default);
Vue.component('carousel', require('./components/front/CarouselComponent.vue').default);
Vue.component('product-colors', require('./components/admin/ProductColorsComponent.vue').default);
Vue.component('front-navbar', require('./components/front/NavbarComponent.vue').default);
Vue.component('filter-products', require('./components/front/FilterComponent.vue').default);
Vue.component('comment', require('./components/front/CommentComponent.vue').default);
Vue.component('store', require('./components/front/StoreComponent.vue').default);
Vue.component('cart-icon', require('./components/front/CartIconComponent.vue').default);
Vue.component('promo-code', require('./components/front/PromoCodeComponent.vue').default);

//Laravel Vue Pagination component
Vue.component('pagination', require('laravel-vue-pagination'));

//Passport Components
Vue.component(
  'passport-clients',
  require('./components/passport/Clients.vue').default
);

Vue.component(
  'passport-authorized-clients',
  require('./components/passport/AuthorizedClients.vue').default
);

Vue.component(
  'passport-personal-access-tokens',
  require('./components/passport/PersonalAccessTokens.vue').default
);

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const app = new Vue({
    el: '#app',
    //render: (h) => h(App),
    router
});
