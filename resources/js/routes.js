const routes = [
    //front routes
    { path: '/', component: require('./components/front/IndexComponent.vue').default  },
    { path: '/collections/:collection', name: 'collections', component: require('./components/front/CollectionComponent.vue').default  },
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
    { path: '/admin/users', component: require('./components/admin/UsersComponent.vue').default  },
    { path: '/admin/passport', component: require('./components/admin/PassportComponent.vue').default  },
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