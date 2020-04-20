//import cart_exists from './middleware/cart_exists';

const routes = [
    //front routes
    { path: '/', name: 'index', component: require('./components/front/IndexComponent.vue').default  },
    { path: '/collections/:collection', name: 'collections', component: require('./components/front/CollectionComponent.vue').default,
      children: [
        { path: ':category', name: 'front-category', component: require('./components/front/FrontCategoryComponent.vue').default  },
        //{ path: ':subCategory', name: 'front-subCategory', component: require('./components/front/FrontSubCategoryComponent.vue').default  },
      ]  
    },
    { path: '/products/:product', name: 'front-product', component: require('./components/front/ProductComponent.vue').default },
    { path: '/stores', name: 'stores', component: require('./components/front/StoresComponent.vue').default },
    //{ path: '/stores/:url', name: 'store', component: require('./components/front/StoreLocationComponent.vue').default },
    { path: '/cart', name: 'cart', beforeEnter: (to, from, next) => {if($cart) { next(); } else { console.log($cart); next(from.path); } }, component: require('./components/front/CartComponent.vue').default },
    { path: '/cart/checkout', name: 'checkout', beforeEnter: (to, from, next) => {if($cart == true) { next(); } else { next(from.path); } }, component: require('./components/front/CheckoutComponent.vue').default },
    //admin routes
    { path: '/admin', component: require('./components/admin/DashboardComponent.vue').default  },
    { path: '/admin/categories', component: require('./components/admin/CategoryComponent.vue').default  },
    { path: '/admin/brands', component: require('./components/admin/BrandComponent.vue').default  },
    { path: '/admin/products', component: require('./components/admin/ProductsComponent.vue').default },
    { path: '/admin/products/:id/edit', name: 'edit-product', component: require('./components/admin/EditProductComponent.vue').default },
    { path: '/admin/products/:id/add-variant', name: 'add-variant', component: require('./components/admin/AddVariantComponent.vue').default },
    { path: '/admin/products/:id/variants', name: 'product-variants', component: require('./components/admin/VariantComponent.vue').default },
    { path: '/admin/products/:id/edit-variant/:variant_id', name: 'edit-variant', component: require('./components/admin/EditVariantComponent.vue').default },
    { path: '/admin/add-product', component: require('./components/admin/AddProductComponent.vue').default  },
    { path: '/admin/products/:id/add-color-variant', name: 'add-color-variant', component: require('./components/admin/AddColorVariantComponent.vue').default  },
    { path: '/admin/products/:id/edit-color-variant', name: 'edit-color-variant', component: require('./components/admin/EditColorVariantComponent.vue').default  },
    { path: '/admin/users', component: require('./components/admin/UsersComponent.vue').default  },
    { path: '/admin/passport', component: require('./components/admin/PassportComponent.vue').default  },
    { path: '/admin/manage-coupons', name: 'manage-coupons', component: require('./components/admin/CouponsComponent.vue').default },
    { path: '/admin/add-store', name: 'add-store', component: require('./components/admin/AddStoreComponent.vue').default }, 
    { path: '/admin/stores', name: 'manage-stores', component: require('./components/admin/StoresComponent.vue').default },
    { path: '/admin/example', component: require('./components/admin/ExampleComponent.vue').default, 
/*         children:  [
            {
              path: ':id',
              component: require('./components/SubExampleComponent.vue').default,
              props: { default: true, sidebar: false }
            },
          ] */
    },
    { path: '*', component: require('./components/admin/404.vue').default }  
];

module.exports = routes;