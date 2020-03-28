<template>
    <div class="container">
        <filter-products v-bind:filters="filters" v-on:filtersEmit="filterProducts($event)"></filter-products>
        <!--Section-->
        <section class="text-center mb-4">
            <!--Grid row-->
            <div class="row wow fadeIn">

                <!--Grid column-->
                <div v-for="(product, index) in products.data"  :key="index" class="col-lg-3 col-md-6 mb-4">
                    <!--Card-->
                    <div class="card" style="height: 360px">
                        <router-link :to="{ name: 'front-product', params: { product: product.url }}" tag="a">
                            <!--Card image-->
                            <div>
                                <img v-if="product.cover_image !== 'not_selected'" :src="'/images/products/' + product.image_folder + '/' + product.cover_image" class="card-img-top" style="width:100%; height:232px; object-fit:cover" alt="">
                                <router-link :to="{ name: 'front-product', params: { product: product.url }}" class="" tag="a">
                                    <div class="mask rgba-white-slight"></div>
                                </router-link>
                            </div>
                            <!--Card image-->
                            <!--Card content-->
                            <div class="card-body text-center">
                                <!--Category & Title-->
                                <h5 href="" class="grey-text">
                                    {{ product.category.title }}
                                </h5>
                                <h5>
                                    <strong>
                                        <router-link :to="{ name: 'front-product', params: { product: product.url }}" class="dark-grey-text" tag="a">
                                            {{ product.title }}
                                            <span class="badge badge-pill danger-color">NEW</span>
                                        </router-link>
                                    </strong>
                                </h5>
                                <h4 class="font-weight-bold blue-text">
                                    <span v-if="product.discount">
                                        <s>${{ product.price }}</s>
                                        <strong class="text-danger">${{ product.discount }}</strong>
                                    </span>
                                    <span v-if="!product.discount">
                                        <strong>${{ product.price }}</strong>
                                    </span>
                                </h4>
                            </div>
                            <!--Card content-->
                        </router-link>
                    </div>
                    <!--Card-->

                </div>
                <!--Grid column-->
            </div>
            <!--Grid row-->

        </section>
        <!--Section: Products v.3-->                                               

        <!--Pagination-->
        <div class="container">
            <div class="mx-auto">
                <pagination :data="products" @pagination-change-page="getPage"></pagination> 
            </div> 
        </div>
        <!--Pagination-->
   
    </div>
</template>

<script>
    export default {
        data() {
            return {
                currentPage: Number,
                products: {},
                filters: {}
            }         
        },
        methods: {
            loadProducts(filters = 'all') {
                let params = this.$route.params;
                if(params.category) {
                    axios.get(`/api/getProducts/${params.collection}/${params.category}/${filters}`).then(
                    ({ data }) => {
                            this.products = data.products;
                            this.filters = data.filters;
                        }
                    ).catch(e => console.log(e)); 
                } else {
                    
                }
            },
            getPage(page = 1) {
                this.currentPage = page;
                let params = this.$route.params;
                axios.get(`/api/getProducts/${params.collection}/${params.category}?page=${page}`)
                    .then(response => {
                        this.products = response.data.products;
                    }
                ).catch(err => {
                    console.log(err);
                }) 
            },
            filterProducts(filters) {
                console.log(filters)
                this.loadProducts(JSON.stringify(filters));
            }
        },
        created() {
            this.loadProducts();
        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>
