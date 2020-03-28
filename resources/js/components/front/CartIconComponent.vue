<template>
    <li class="nav-item" v-if="cart.exists">
        <router-link to="/cart" class="nav-link waves-effect" tag="a" active-class="active" exact>
            <span class="badge red z-depth-1 mr-1"> {{ cart.count }} </span>
            <i class="fas fa-shopping-cart"></i>
            <span class="clearfix d-none d-sm-inline-block"> Cart </span>
        </router-link>
    </li>    
</template>

<script>
    export default {
        data() {
            return {
                cart: { exists: false, count: 0 }
            }
        },
        methods: {
            loadCart() { 
                axios.get('/api/cart').then(
                ({ data }) => {
                        if(data.cart.cart_items) {
                            this.cart.exists = true;
                            console.log(data.cart.cart_items.length)
                            this.cart.count = data.cart.cart_items.length;
                        }
                    }
                ).catch((e) => {
                    this.cart.exists = false;
                    this.cart.count = 0;
                }); 
            },
        },
        created() {      
            axios.get('/api/cookieExist')
            .then((cookie) => {
                if(cookie) {
                    this.loadCart();
                }              
            })
            .catch((err) => {
            }); 
        },   
        mounted() {
            this.$root.$on('CART_UPDATE', (newCount) => {                
                if(newCount === 0) {
                    this.cart.exists = false;
                    this.cart.count = newCount;
                } else {
                    this.cart.exists = true;
                    this.cart.count = newCount;
                }               
            })
        }
    }
</script>