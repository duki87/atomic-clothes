<template>
    <div class="container mt-2" v-if="ready">
        <div class="col-md-12 mb-4 mx-auto">

            <!-- Heading -->
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">Your Shopping cart</span>
                <span class="badge badge-secondary badge-pill">{{ form.cart_items.length }}</span>
            </h4>

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
                                <button @click="increase(item)" type="button" class="btn btn-primary px-3"><i class="fas fa-plus" aria-hidden="true"></i></button>
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
                    <tr>
                        <td colspan="4" class="text-center">
                            <button class="btn btn-secondary btn-md waves-effect m-0" type="button">Continue to Checkout</button>
                            <button class="btn btn-default btn-md waves-effect m-0" type="button">Use Promo Code</button>
                        </td>
                        <td class="text-center">
                            <strong>Total:</strong>
                        </td>
                        <td class="text-center">
                            <strong>${{ form.total }}</strong>
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
                    status: Number,
                    cart_items: {}               
                })
            }
        },
        methods: {
            loadCart() {
                axios.get('/api/cart').then(
                ({ data }) => {
                        this.form.fill(data.cart);
                        this.ready = true;
                    }
                ).catch((e) => {
                    this.$router.push('/');
                }); 
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
                axios.get(`/api/cart/decrease/${item.id}`)
                    .then(res => {
                        this.loadCart();
                    })
                    .catch(err => {
                        console.log(err);
                    });
            },
            deleteItem() {
                axios.get(`/api/cart/deleteItem/${item.id}`)
                    .then(res => {
                        this.loadCart();
                    })
                    .catch(err => {
                        console.log(err);
                    });
            },
            deleteCart(item) {
                this.form.delete(`/api/cart/${this.form.id}`)
                    .then(res => {
                        this.$router.push('/');
                    })
                    .catch(err => {
                        console.log(err)
                    })
            }
        },
        beforeMount() {
            axios.get('/api/cookieExist')
            .then(cookie => {
                return true;
            })
            .catch(err => {
                console.log(err)
                this.$router.go(-1);
            });
        },
        mounted() {
            this.loadCart();
            console.log('Component mounted.')
        }
    }
</script>
