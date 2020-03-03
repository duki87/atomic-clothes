<template>
    <div class="container mt-2" v-if="ready">
        <div class="col-md-8 mb-4 mx-auto">

            <!-- Heading -->
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">Your cart</span>
                <span class="badge badge-secondary badge-pill">{{ form.cart_items.length }}</span>
            </h4>

            <!-- Cart -->
            <ul class="list-group mb-3 z-depth-1">
                <li v-for="(item, index) in form.cart_items" :key="index" class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0">{{ item.product.title }}</h6>
                        <small class="text-muted">{{ item.product.code+''+item.variant.sku }}</small>
                    </div>
                    <span class="text-muted">${{ item.product.price }}</span>
                </li>

                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (USD)</span>
                    <strong>${{ form.total }}</strong>
                </li>
            </ul>
            <!-- Cart -->

            <!-- Promo code -->
            <form class="card p-2">
                <div class="input-group">
                <input type="text" class="form-control" placeholder="Promo code" aria-label="Recipient's username" aria-describedby="basic-addon2">
                <div class="input-group-append">
                    <button class="btn btn-secondary btn-md waves-effect m-0" type="button">Redeem</button>
                </div>
                </div>
            </form>
            <!-- Promo code -->

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
