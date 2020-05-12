<template>
    <div style="margin-top:100px">
        <div class="container mt-2" v-if="ready">      
            <div class="col-md-12 mb-4 mx-auto">

                <!-- Heading -->
                <h3 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Your Shopping cart</span>
                    <span class="badge badge-secondary badge-pill">{{ form.cart_items.length }}</span>
                </h3>
                <hr>

                <!-- Cart -->
                <table class="table table-striped table-responsive-md btn-table">
                    <thead>
                        <tr>
                            <th class="text-center">#</th>
                            <th>Product</th>
                            <th class="text-center">Image</th>
                            <th class="text-center">Price</th>
                            <th class="text-center">Quantity</th>
                            <th class="text-center">Subtotal</th>
                            <th class="text-center">Delete</th>
                        </tr>
                    </thead>
                        <tbody>
                            <tr v-for="(item, index) in form.cart_items" :key="index">
                                <th scope="row" class="text-center">{{ ++index }}</th>
                                <td>
                                    {{ item.product.title+' '+item.variant.variant_color.color+' '+item.variant.size }}
                                    <br>
                                    <small>
                                        {{ item.product.code+''+item.variant.sku }}
                                    </small>
                                </td>
                                <td class="text-center">
                                    <img :src="'/images/products/' + item.product.image_folder + '/' + item.variant.variant_color.color_variant_images[0].image" style="width:50px" alt="">
                                </td>
                                <td class="text-center">
                                    <span v-if="item.product.discount">
                                        <s>${{ item.product.price }}</s><br>
                                        <strong>${{ item.product.discount }}</strong>
                                    </span>
                                    <span v-if="!item.product.discount">
                                        <strong>${{ item.product.price }}</strong>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <button @click="decrease(item)" type="button" class="btn btn-primary px-3"><i class="fas fa-minus" aria-hidden="true"></i></button>
                                    {{ item.quantity }}
                                    <button @click="increase(item)" type="button" :disabled="item.variant.stock == 0" class="btn btn-primary px-3"><i class="fas fa-plus" aria-hidden="true"></i></button>
                                    <br>
                                    <small class="text-danger" v-if="item.variant.stock == 1">Only one item left!</small>
                                    <small class="text-danger" v-if="item.variant.stock == 0">No more items on stock!</small>
                                </td>
                                <td class="text-center">
                                    <strong>${{ item.subtotal }}</strong>
                                </td>
                                <td class="text-center">
                                    <button @click="deleteItem(item)" type="button" class="btn btn-danger px-3"><i class="fas fa-times" title="Delete Item"></i></button>
                                </td>
                            </tr>
                    </tbody>
                    <tfoot>
                        <tr v-if="form.promo_code_id">
                            <td colspan="4" class="text-center"></td>
                            <td class="text-center">
                                <strong>Used Promo Code:  {{ form.promo_code.coupon_series }} {{ form.promo_code.coupon_no }}. Discount ({{ coupon.discount }} %):</strong>
                            </td>
                            <td class="text-center">
                                <strong>- ${{ form.discount }}</strong>
                            </td>
                            <td class="text-center"></td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-center">
                                <button class="btn btn-secondary btn-md waves-effect m-0" type="button">Continue to Checkout</button>
                                <button v-if="!form.promo_code_id" class="btn btn-default btn-md waves-effect m-0" type="button" data-toggle="modal" data-target="#promoCodeModal">Use Promo Code</button>
                                <button v-if="form.promo_code_id" @click="removeCoupon" class="btn btn-danger btn-md waves-effect m-0" type="button">Remove Coupon</button>
                            </td>
                            <td class="text-center">
                                <strong>Total:</strong>
                            </td>
                            <td class="text-center">
                                <strong>
                                    <span v-if="form.discount">${{ (form.total - form.discount).toFixed(2) }}</span>
                                    <span v-else>${{ form.total }}</span>
                                </strong>
                            </td>
                            <td class="text-center">
                                <button @click="deleteCart" type="button" class="btn btn-danger px-3"><i class="fas fa-trash" title="Delete Cart"></i></button>
                            </td>
                        </tr>
                    </tfoot>
                </table>             
                <!-- Cart -->
            </div>
        </div>
        <promo-code v-on:couponApplied="couponApplied($event)" v-bind:couponRemoved="couponRemoved"></promo-code>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                ready: false,
                form: new Form({
                    id: Number,
                    user_id: Number,
                    total: Number,
                    discount: Number,
                    status: Number,
                    promo_code_id: Number,
                    cart_items: {},
                    promo_code: {}                             
                }),
                valid_coupon: false,
                coupon: {},
                couponRemoved: false
            }
        },
        methods: {
            loadCart() {
                axios.get('/api/cart').then(
                ({ data }) => {
                    console.log(data.cart)
                        if(data.cart.cart_items.length === 0) {
                            this.deleteCart();
                        }
                        this.form.fill(data.cart);
                        this.ready = true;
                        this.cartUpdate(data.cart.cart_items.length);
                    }
                ).catch((e) => {
                    this.$router.push('/');
                }); 
            },
            couponApplied(coupon) {
                this.valid_coupon = true;
                this.coupon = coupon;
                this.loadCart();
            },
            removeCoupon() {
                axios.get(`/api/user-promo-codes/remove-promo-code/${this.form.promo_code.coupon_series}-${this.form.promo_code.coupon_no}`)
                    .then(res => {
                        this.couponRemoved = true;
                        this.coupon = {};
                        this.valid_coupon = false;
                        this.loadCart();
                        this.couponRemoved = false;
                    })
                    .catch(error => {
                        console.log(error);
                    })
            },
            increase(item) {
                axios.get(`/api/cart/increase/${item.id}`)
                    .then(res => {
                        this.loadCart();
                    })
                    .catch(err => {
                        console.log(err);
                    });
            },
            decrease(item) {
                if(item.quantity === 1) {
                    this.deleteItem(item);
                } else {
                    axios.get(`/api/cart/decrease/${item.id}`)
                        .then(res => {
                            this.loadCart();
                        })
                        .catch(err => {
                            console.log(err);
                        });
                }
            },
            deleteItem(item) {
                axios.get(`/api/cart/deleteItem/${item.id}`)
                    .then((res) => {
                        this.loadCart();
                    })
                    .catch(err => {
                        console.log(err);
                    });
            },
            deleteCart() {
                this.form.delete(`/api/cart/${this.form.id}`)
                    .then((res) => {
                        this.cartUpdate(0);
                        this.$router.push('/');
                    })
                    .catch(err => {
                        console.log(err);
                    })
            },
            cartUpdate(quantity) {
                this.$root.$emit('CART_UPDATE', quantity);
            }
        },
        beforeMount() {
            axios.get('/api/cookieExist')
            .then((cookie) => {
                if(cookie) {
                    this.loadCart();
                }            
            })
            .catch(err => {
                this.$router.go(-1);
            });   
        },
        created() {
            
        },   
        mounted() {
            this.$root.$emit('CAROUSEL_SHOW', false);
        }
    }
</script>
