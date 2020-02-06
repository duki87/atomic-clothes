<template>
    <div class="container" id="app">
        <!--Section: Products v.3-->
        <section class="text-center mb-4">

            <!--Grid row-->
            <div class="row wow fadeIn">

                <!--Grid column-->
                <div v-for="(product, index) in products.data"  :key="index" class="col-lg-3 col-md-6 mb-4">
                    <!--Card-->
                    <div class="card">
                    <!--Card image-->
                    <div class="view overlay">
                        <img v-if="product.cover_image !== 'not_selected'" :src="'/images/products/' + product.image_folder + '/' + product.cover_image" class="card-img-top" alt="">
                        <router-link :to="{ name: 'front-product', params: { product: product.id }}" class="" tag="a">
                            <div class="mask rgba-white-slight"></div>
                        </router-link>
                    </div>
                    <!--Card image-->

                    <!--Card content-->
                    <div class="card-body text-center">
                        <!--Category & Title-->
                        <a href="" class="grey-text">
                        <h5>{{ product.catTitle }}</h5>
                        </a>
                        <h5>
                        <strong>
                            <router-link :to="{ name: 'front-product', params: { product: product.id }}" class="dark-grey-text" tag="a">
                                {{ product.title }}
                                <span class="badge badge-pill danger-color">NEW</span>
                            </router-link>
                        </strong>
                        </h5>

                        <h4 class="font-weight-bold blue-text">
                        <strong>{{ product.price }} $</strong>
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
        <nav class="d-flex justify-content-center wow fadeIn">
            <ul class="pagination pg-blue">

            <!--Arrow left-->
            <li class="page-item disabled">
                <a class="page-link" href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
                <span class="sr-only">Previous</span>
                </a>
            </li>

            <li class="page-item active">
                <a class="page-link" href="#">1
                <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="page-item">
                <a class="page-link" href="#">2</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="#">3</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="#">4</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="#">5</a>
            </li>

            <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
                <span class="sr-only">Next</span>
                </a>
            </li>
            </ul>
        </nav>
        <!--Pagination-->
    </div>
</template>

<script>
    export default {
        data() {
            return {
                products: {}
            }
        },
        methods: {
            loadProducts() {
                let params = this.$route.params;
                axios.get(`/api/getProducts/${params.collection}/${params.category}`).then(
                ({ data }) => {
                        console.log(data)
                        this.products = data.products;
                    }
                ).catch(e => console.log(e)); 
            },
        },
        created() {
            this.loadProducts();
            //console.log(this.$route.params)
        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>
