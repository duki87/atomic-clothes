<template>
    <div class="container">
        <!-- <router-view></router-view> -->
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Add Product Variant</div> 
                    <form @submit.prevent="createVariant">                          
                        <div class="card-body">
                            <button type="button" class="btn btn-secondary">All Variant</button>
                            <button type="button" class="btn btn-danger">Delete Variant</button>
                            <h3 class="mt-2">Enter Product Variant Data</h3>
                            <hr>                                  
                            <div class="form-row">
                                <div class="col-md-4">
                                    <label for="sku">SKU</label>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="sku">{{product.code}}</span>
                                        </div>
                                        <input v-model="form.sku" :class="{'is-invalid': form.errors.has('sku')}" type="text" class="form-control" id="sku" placeholder="SKU" aria-describedby="sku">
                                    </div>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.sku">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="title">Select Color...</label>
                                    <select v-model="form.color" name="color" id="color" :class="{'is-invalid': form.errors.has('color')}" class="custom-select browser-default">
                                        <option value="">Select Color</option>
                                        <option value="Red">Red</option>
                                        <option value="Blue">Blue</option>
                                        <option value="Green">Green</option>
                                        <option value="Pink">Pink</option>
                                        <option value="Purple">Purple</option>
                                        <option value="White">White</option>
                                        <option value="Black">Black</option>
                                        <option value="Grey">Grey</option>
                                        <option value="alt_color">Describe</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.color">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="alt_color">Or Describe Colors</label>
                                    <input v-model="form.color" type="text" class="form-control" id="alt_color" placeholder="Describe Colors">
                                </div>
                                <div class="col-md-4">
                                    <label for="title">Select Size</label>
                                    <select v-model="form.size" name="size" id="size" :class="{'is-invalid': form.errors.has('size')}" class="custom-select browser-default">
                                        <option value="">Select Size</option>
                                        <option value="XS">XS</option>
                                        <option value="S">S</option>
                                        <option value="M">M</option>
                                        <option value="L">L</option>
                                        <option value="XL">XL</option>
                                        <option value="XXL">XXL</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.size">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="title">Stock Quantity</label>
                                    <input type="text" v-model="form.stock" :class="{'is-invalid': form.errors.has('stock')}" @keypress="validateNumbers" class="form-control" id="stock" placeholder="Stock Quantity">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.stock">{{err}}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="md-form input-group mb-3">
                                <input type="text" v-model="product_tag" @keyup.enter="addTag" class="form-control" 
                                id="add_tags" placeholder="Add Category Tag and Press Enter">
                                <div class="input-group-append">
                                    <button @click="addTag" class="btn btn-md btn-secondary m-0 px-3" type="button" >Add</button>
                                </div>
                            </div>          
                            <div class="p-2" :class="[form.tags.length > 0 ? borderClass : '']">
                                <a v-for="(tag, index) in form.tags" 
                                @click="removeTag(index)" @mouseover="hoverBtn = index" @mouseout="hoverBtn = undefined" 
                                :class="[isHovering(index) ? 'badge badge-danger' : 'badge badge-default']" class=" d-inline p-2 ml-2">
                                    {{tag}}
                                </a>                       
                            </div> 
                        </div>   
                        <div class="card-footer">
                            <button type="submit" class="btn btn-default">Create</button>
                            <button type="button" class="btn btn-outline-default" @click="resetForm">Reset</button>                             
                        </div>
                    </form>               
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                form: new Form({
                    product_id: '',
                    sku: '',
                    color: '',
                    size: '',
                    stock: 0,
                    tags: []
                }),
                alt_color: '',
                product: {},
                color: '',
                product_tag: '',
                borderClass: 'border border-secondary',
                hoverBtn: undefined,        
                formErrors: {},
                image: '',
                product_tag: ''
            }          
        },
        methods: {
            createVariant() {
                this.$Progress.start();
                if(this.formErrors) {
                    this.$Progress.fail();
                }
                this.$Progress.start();
/*                 this.form.post('/api/product')
                .then((res) => {
                    this.$Progress.finish();
                    this.form.reset();
                    this.$router.push({ name: 'product-variants', params: { id: res.data.product_id }});
                })
                .catch(
                    (err) => {
                        this.formErrors = err.response.data.errors;
                        this.$Progress.fail();
                    }
                ) */
            },
            addTag() {
                if(this.product_tag !== '') {
                    this.form.tags.push(this.product_tag);
                    this.product_tag = '';
                }
            },
            removeTag(index) {
                this.form.tags.splice(index, 1);
            },
            isHovering(index) {
                return this.hoverBtn == index;
            },
            loadProduct() {
                let product_id = this.$router.history.current.params.id;
                axios.get('/api/product/'+product_id)
                .then(
                    ({data}) => {
                        console.log(data);
                        this.product = data.product;
                    }
                ).catch(err => console.log(err));
            },
            validateNumbers(event) {
                let allowed = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'Backspace', '.'];
                if(allowed.indexOf(event.key) == -1) {
                    event.preventDefault();
                }
            },
            resetForm() {
                this.form.reset();
            }
        },
        created() {
            this.loadProduct();
        },
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
