<template>
    <div class="container" v-if="ready" style="margin-top:70px">  
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb cyan lighten-4 mt-2" v-if="form.main_category">
                <li class="breadcrumb-item">
                    <router-link :to="{ name: 'collections', params: { collection: form.main_category.url }}" tag="a">
                        {{ form.main_category.title }}
                    </router-link>
                </li>
                <li class="breadcrumb-item">
                    <router-link :to="{ name: 'front-category', params: { collection: form.main_category.url, category: form.sub_category.url }}" tag="a">
                        {{ form.sub_category.title }}
                    </router-link>
                </li>
                <li class="breadcrumb-item active">{{ form.title }}</li>
            </ol>
        </nav>
        <div class="container dark-grey-text mt-5">
            <!--Grid row-->
            <div class="row wow fadeIn">
                <!--Grid column-->
                <div class="col-md-6 mb-4" v-if="color_variant_images && color_variant_images.length > 0">
                    <img :src="'/images/products/' + form.image_folder + '/' + color_variant_images[activeImage].image" class="img-fluid" alt="">
                    <div class="d-flex align-content-start flex-wrap mt-2" style="flex-wrap: wrap;">
                        <img v-for="(image, index) in color_variant_images" :key="index" :src="'/images/products/' + form.image_folder + '/' + image.image" alt="thumbnail" class="img-thumbnail mt-2" style="cursor:pointer; object-fit:cover; position:relative; width:32%; height:100px" @click="changeActiveImage(index)">
                    </div>
                </div>
                <!--Grid column-->

                <!--Grid column-->
                <div class="col-md-6 mb-4">
                    <span id="rateMe2" class="empty-stars"></span>
                    <!--Content-->
                    <div class="p-4">
                        <div class="mb-3">
                            <a href="" v-for="(tag, index) in form.tags" :key="index">
                                <span class="badge red mr-1" :class="tagColors[index]">{{ tag }}</span>
                            </a>
                        </div>
                        <p class="lead" v-if="form.discount">
                            <span>
                                <del>$ {{ form.price }}</del>
                            </span>
                            <span class="mr-1">
                                $ {{ form.discount }}
                            </span>
                        </p>
                        <p class="lead" v-if="!form.discount">
                            <span class="mr-1">
                                $ {{ form.price }}
                            </span>
                        </p>
                        <p class="lead font-weight-bold">Description</p>
                        <p>
                            {{ form.description }}
                        </p>

                        <p class="lead font-weight-bold">Select Color And Size</p>
                        <div class="dropdown d-inline mb-4">
                            <button class="btn btn-sm btn-primary dropdown-toggle" type="button" id="dropdownMenu6" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                                {{ selectColorText }}
                            </button>
                            <div class="dropdown-menu dropdown-menu-ch" aria-labelledby="dropdownMenu6">
                                <a v-for="(color, index) in form.colors" :key="index" class="dropdown-item" :class="{'active': color.id == selectedColor.id}" @click="selectColor(color)">{{ color.color }} </a>
                            </div>
                        </div>

                        <div class="dropdown d-inline mb-4">
                            <button class="btn btn-sm btn-primary dropdown-toggle" type="button" id="dropdownMenu6" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                                {{ selectSizeText }}
                            </button>
                            <div class="dropdown-menu dropdown-menu-ch" aria-labelledby="dropdownMenu6">
                                <a v-for="(sizeVariant, index) in availableSizes" :key="index" class="dropdown-item" :class="{'active': sizeVariant.id == selectedSize.id}" @click="selectSize(sizeVariant)">{{ sizeVariant.size }} (available: {{ sizeVariant.stock }}) </a>
                            </div>
                        </div>

                        <form class="d-flex justify-content-left mt-2" @submit.prevent="addToCart">
                            <!-- Default input -->
                            <input v-model="cartItemForm.quantity" type="number" min="0" value="1" aria-label="Search" class="form-control" style="width: 100px">
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
                    <h4 class="my-4 h4">Suggested For You</h4>
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
                ready: false,
                form: new Form({
                    id: Number,
                    main_category_id: Number,
                    sub_category_id: Number,
                    category_id: Number,
                    brand_id: Number,
                    brand: {},
                    main_category: {},
                    sub_category: {},
                    category: {},
                    code: String,
                    title: String,
                    url: String,
                    description: String,
                    price: Number,
                    discount: Number,
                    image_folder: String,
                    cover_image: String,
                    tags: [],
                    status: '',
                    colors: [{
                        id: '',
                        product_id: '',
                        color: '',
                    }]                 
                }),
                cartItemForm: new Form({
                    id: Number,
                    cart_id: Number,
                    product_id: Number,
                    variant_id: Number,
                    product_price: Number,
                    quantity: 1,
                    subtotal: Number
                }),
                activeImage: 0,
                selectColorText: 'Select Color',
                selectSizeText: 'Select Size',
                tagColors: ['red', 'blue', 'purple', 'green', 'yellow', 'violet', 'orange'],
                selectedColor: {},
                selectedSize: {},
                availableSizes: [],
                color_variant_images: []               
            }
        },
        methods: {
            loadProduct() {
                let params = this.$route.params;
                axios.get('/api/getProduct/'+params.product).then(
                ({ data }) => {
                        this.form.fill(data.product);
                        let color = this.form.colors[0];
                        this.selectedColor = color;
                        this.availableSizes = color.variants;
                        this.selectedSize = color.variants[0];
                        this.selectColorText = color.color;
                        this.selectSizeText = `${color.variants[0].size} (available: ${color.variants[0].stock})`;
                        this.color_variant_images = color.color_variant_images;
                        this.form.colors = data.product.colors.filter(colorVariant => {
                            return colorVariant.variants.length > 0;
                        });
                        this.ready = true;
                    }
                ).catch((e) => {
                    this.$router.push('/');
                }); 
            },
            selectSize(sizeVariant) {
                this.selectedSize = sizeVariant;
                this.selectSizeText = `${sizeVariant.size} (available: ${sizeVariant.stock})`;
            },
            selectColor(color) {
                this.selectedColor = color;
                this.selectColorText = color.color;
                this.availableSizes = color.variants.filter(variant => {
                    return variant.stock > 0;
                });
                this.selectSizeText = `${this.availableSizes[0].size} (available: ${this.availableSizes[0].stock})`;
                this.color_variant_images = color.color_variant_images;
                this.selectedSize = this.availableSizes[0];
            },
            changeActiveImage(index) {
                this.activeImage = index;
            },
            addToCart() {              
                let product_price = this.form.discount ? this.form.discount : this.form.price;
                this.cartItemForm.cart_id = '';
                this.cartItemForm.product_id = this.form.id;
                this.cartItemForm.variant_id = this.selectedSize.id;
                this.cartItemForm.product_price = product_price;
                this.cartItemForm.subtotal = this.cartItemForm.quantity * product_price;
                this.cartItemForm.post('/api/addToCart')
                .then((added) => {
                    this.loadCart();
                    $cart = true;
                })
                .catch(err => {
                    console.log(err);
                })
            },
            loadCart() { 
                axios.get('/api/cart').then(
                ({ data }) => {
                        if(data.cart.cart_items) {
                            this.cartUpdate(data.cart.cart_items.length);
                        }
                    }
                ).catch((e) => {
                    this.cart.exists = false;
                    this.cart.count = 0;
                }); 
            },
            cartUpdate(quantity) {
                this.$root.$emit('CART_UPDATE', quantity);
            },
        },
        created() {
            this.loadProduct();
        },
        beforeMount() {
            
        },
        mounted() {     
            //console.log('Component mounted.')
        }
    }
</script>
