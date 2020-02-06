<template>
    <div class="container">  
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb cyan lighten-4 mt-2" v-if="product.mainCat">
                <li class="breadcrumb-item">
                    <router-link :to="{ name: 'collections', params: { collection: product.mainCat.url }}" tag="a">
                        {{ product.mainCat.title }}
                    </router-link>
                </li>
                <li class="breadcrumb-item">
                    <router-link :to="{ name: 'front-category', params: { collection: product.mainCat.url, category: product.subCat.url }}" tag="a">
                        {{ product.subCat.title }}
                    </router-link>
                </li>
                <li class="breadcrumb-item">
                    <router-link :to="{ name: 'collections', params: { collection: product.cat.url }}" tag="a">
                        {{ product.cat.title }}
                    </router-link>
                </li>
                <li class="breadcrumb-item active">{{ product.title }}</li>
            </ol>
        </nav>
        <div class="container dark-grey-text mt-5">
            <!--Grid row-->
            <div class="row wow fadeIn">
                <!--Grid column-->
                <div class="col-md-6 mb-4" v-if="form.variant_images.length > 0">
                    <img :src="'/images/products/' + product.image_folder + '/' + form.variant_images[activeImage].image" class="img-fluid" alt="">
                    <div class="d-flex justify-content-between mt-2" style="flex-wrap: wrap;">
                        <img v-for="(image, index) in form.variant_images" :key="index" :src="'/images/products/' + product.image_folder + '/' + image.image" alt="thumbnail" class="img-thumbnail mt-2" style="cursor:pointer; object-fit:cover; position:relative; width:32%; height:100px" @click="changeActiveImage(index)">
                    </div>
                </div>
                <!--Grid column-->

                <!--Grid column-->
                <div class="col-md-6 mb-4">
                    <!--Content-->
                    <div class="p-4">
                        <div class="mb-3">
                            <a href="" v-for="(tag, index) in product.tags" :key="index">
                                <span class="badge red mr-1" :class="tagColors[index]">{{ tag }}</span>
                            </a>
                        </div>
                        <p class="lead" v-if="product.discount">
                            <span>
                                <del>$ {{ product.price }}</del>
                            </span>
                            <span class="mr-1">
                                $ {{ product.discount }}
                            </span>
                        </p>
                        <p class="lead" v-if="!product.discount">
                            <span class="mr-1">
                                $ {{ product.price }}
                            </span>
                        </p>
                        <p class="lead font-weight-bold">Description</p>
                        <p>
                            {{ product.description }}
                        </p>

                        <p class="lead font-weight-bold d-inline">Select Color And Size</p>
                        <div class="dropdown d-inline mb-4">
                            <button class="btn btn-sm btn-primary dropdown-toggle" type="button" id="dropdownMenu6" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                                {{ selectVariantText }}
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenu6">
                                <a v-for="(variant, index) in product.variants" :key="index" class="dropdown-item" :class="{'active': form.id == variant.id}" @click="selectVariant(variant)">{{ variant.color }} {{ variant.size }} (available: {{ variant.stock }}) </a>
                            </div>
                        </div>

                        <form class="d-flex justify-content-left mt-2">
                            <!-- Default input -->
                            <input type="number" min="0" value="1" aria-label="Search" class="form-control" style="width: 100px">
                            <button class="btn btn-primary btn-md my-0 p" type="submit">Add to cart
                                <i class="fas fa-shopping-cart ml-1"></i>
                            </button>
                        </form>
                    </div>
                    <!--Content-->
                </div>
                <!--Grid column-->
            </div>
            <!--Grid row-->
            <hr>
            <!--Grid row-->
            <div class="row d-flex justify-content-center wow fadeIn">
                <!--Grid column-->
                <div class="col-md-6 text-center">
                    <h4 class="my-4 h4">Similar Products</h4>
                </div>
                <!--Grid column-->
            </div>
            <!--Grid row-->

            <!--Grid row-->
            <div class="row wow fadeIn">
                <!--Grid column-->
                <div class="col-lg-4 col-md-12 mb-4">
                    <img src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Products/11.jpg" class="img-fluid" alt="">
                </div>
                <!--Grid column-->

                <!--Grid column-->
                <div class="col-lg-4 col-md-6 mb-4">
                    <img src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Products/12.jpg" class="img-fluid" alt="">
                </div>
                <!--Grid column-->

                <!--Grid column-->
                <div class="col-lg-4 col-md-6 mb-4">
                    <img src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Products/13.jpg" class="img-fluid" alt="">
                </div>
                <!--Grid column-->
            </div>
            <!--Grid row-->
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                form: new Form({
                    id: '',
                    sku: '',
                    color: '',
                    size: '',
                    stock: 0,
                    tags: [],
                    variant_images: []
                }),
                product: {},
                activeImage: 0,
                selectVariantText: 'Select',
                tagColors: ['red', 'blue', 'purple', 'green', 'yellow', 'violet', 'orange']
            }
        },
        methods: {
            loadProduct() {
                let params = this.$route.params;
                axios.get('/api/getProduct/'+params.product).then(
                ({ data }) => {
                        this.product = data.product[0];
                        this.form.fill(this.product.variants[0]);
                        this.selectVariantText = `${this.form.color} ${this.form.size}`;
                    }
                ).catch(e => console.log(e)); 
            },
            selectVariant(variant) {
                this.form.fill(variant);
                this.activeImage = 0;
                this.selectVariantText = `${this.form.color} ${this.form.size}`;
            },
            changeActiveImage(index) {
                this.activeImage = index;
            }
        },
        created() {
            this.loadProduct();
        },
        mounted() {     
            //console.log('Component mounted.')
        }
    }
</script>
