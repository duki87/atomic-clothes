<template>
    <div class="container" id="app">
        <!--Section: Products v.3-->
        <section class="text-center mb-4">

            <!--Grid row-->
            <div class="row wow fadeIn">

                <!--Grid column-->
                <div v-for="(product, index) in products.data"  :key="index" class="col-lg-3 col-md-6 mb-4">
                    <!--Card-->
                    <div class="card" style="height: 360px">
                        <!--Card image-->
                        <div class="view overlay">
                            <img v-if="product.cover_image !== 'not_selected'" :src="'/images/products/' + product.image_folder + '/' + product.cover_image" class="card-img-top" style="width:100%; height:232px; object-fit:cover" alt="">
                            <router-link :to="{ name: 'front-product', params: { product: product.url }}" class="" tag="a">
                                <div class="mask rgba-white-slight"></div>
                            </router-link>
                        </div>
                        <!--Card image-->

                        <!--Card content-->
                        <div class="card-body text-center">
                            <!--Category & Title-->
                            <a href="" class="grey-text">
                                <h5>{{ product.category.title }}</h5>
                            </a>
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
                products: {}
            }
        },
        methods: {
            loadProducts() {
                let params = this.$route.params;
                if(params.category) {
                    axios.get(`/api/getProducts/${params.collection}/${params.category}`).then(
                    ({ data }) => {
                            console.log(data)
                            this.products = data.products;
                        }
                    ).catch(e => console.log(e)); 
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
        },
        created() {
            this.loadProducts();
        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>
