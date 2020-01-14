const routes = [
    { path: '/admin', component: require('./components/DashboardComponent.vue').default  },
    { path: '/admin/categories', component: require('./components/CategoryComponent.vue').default  },
    { path: '/admin/brands', component: require('./components/BrandComponent.vue').default  },
    { path: '/admin/products', component: require('./components/ProductsComponent.vue').default },
    { path: '/admin/products/:id', name: 'product', component: require('./components/ProductComponent.vue').default },
    { path: '/admin/products/:id/add-variant', name: 'add-variant', component: require('./components/AddVariantComponent.vue').default },
    { path: '/admin/products/:id/variants', name: 'product-variants', component: require('./components/VariantComponent.vue').default },
    { path: '/admin/products/:id/edit-variant/:variant_id', name: 'edit-variant', component: require('./components/EditVariantComponent.vue').default },
    { path: '/admin/add-product', component: require('./components/AddProductComponent.vue').default  },
    { path: '/admin/users', component: require('./components/UsersComponent.vue')  },
    { path: '*', component: require('./components/404.vue').default }  
];

module.exports = routes;