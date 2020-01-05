<template>
    <div class="container">
        <!-- <router-view></router-view> -->
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Add Product Variant</div> 
                    <form @submit.prevent="createVariant">                          
                        <div class="card-body">             
                            <router-link to="{ name: 'product-variants', params: { id: form.product_id }}" type="button" class="btn btn-default" active-class="active" exact>All Product Variants</router-link>
                            <router-link to="/admin/products" type="button" class="btn btn-secondary" active-class="active" exact>All Products</router-link>
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
                                <div class="col-md-8">
                                    <label for="color">
                                        <span v-if="!describe_color">Choose Color from List</span>
                                        <span v-if="describe_color">Describe Colors</span>
                                    </label>
                                    <div class="input-group">
                                        <select v-if="!describe_color" class="browser-default custom-select" v-model="form.color" name="color" id="color" :class="{'is-invalid': form.errors.has('color')}">
                                            <option value="">Select Color</option>
                                            <option v-for="color in colorsList" v-bind:value="color">{{color}}</option>
                                        </select>
                                        <input v-if="describe_color" type="text" class="form-control" v-model="form.color" id="color" placeholder="Describe Colors">
                                        <div class="input-group-append">
                                            <button @click="changeColorInput" class="btn btn-md btn-secondary m-0 px-3 py-2 z-depth-0 waves-effect" type="button">
                                                <span v-if="describe_color">Choose Color from List</span>
                                                <span v-if="!describe_color">Describe Colors</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="size">Select Size</label>
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

                            <div class="form-row mt-2 d-flex justify-content-around" :class="[product_images.length < 1 ? 'd-none' : '']">
                                <div class="col-md-12">
                                    <p>Add Images To Product Variant</p>
                                </div>
                                <div class="col-md-5 p-2" :class="borderClass">
                                    <img style="cursor:pointer; object-fit:cover; position:relative; width:30%; height:100px" class="ml-2 img-thumbnail" v-for="(imgObj, index) in product_images" alt="thumbnail" @click="addToVariantsImg(index)" :src="'/images/products/' + image_folder + '/' + imgObj.image" :data-index="index">
                                </div>
                                <div class="col-md-5 p-2" :class="borderClass">
                                    <img style="cursor:pointer; object-fit:cover; position:relative; width:30%; height:100px" class="ml-2 img-thumbnail" v-for="(imgObj, index) in variant_images" alt="thumbnail" @click="addToProductsImg(index)" :src="'/images/products/' + image_folder + '/' + imgObj.image" :data-index="index">
                                </div>
                            </div>

                            <div class="md-form input-group mb-3">
                                <div class="col-md-12">
                                    <p>Or Upload More Images</p>
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
                    described_color: '',
                    size: '',
                    stock: 0,
                    tags: [],
                    variant_images: []
                }),
                describe_color: false,
                colorsList: ['Red', 'Blue', 'Green', 'Pink', 'Purple', 'White', 'Black', 'Grey'],
                formErrors: {},
                product: {},
                product_tag: '',
                borderClass: 'border border-secondary',
                hoverBtn: undefined,        
                formErrors: {},
                product_images: [],
                variant_images: [],
                image_folder: ''
            }          
        },
        methods: {
            addToProductsImg(index) {
                let imgObj = this.variant_images[index];
                this.form.variant_images.splice(this.form.variant_images.indexOf(imgObj.id), 1);
                this.product_images.push(imgObj);
                this.variant_images.splice(index, 1);
            },
            addToVariantsImg(index) {
                let imgObj = this.product_images[index];
                this.form.variant_images.push(imgObj.id);
                this.variant_images.push(imgObj);
                this.product_images.splice(index, 1);
            },
            changeColorInput() {
                if(this.describe_color == false) {
                    this.describe_color = true;
                    this.form.color = '';
                } else {
                    this.describe_color = false;
                    this.form.color = '';
                }
            },
            loadProduct() {
                let product_id = this.$router.history.current.params.id;
                axios.get('/api/product/'+product_id)
                .then(
                    ({data}) => {
                        this.product_images = data.product.product_images;
                        this.product = data.product;
                        this.form.product_id = data.product.id;
                        this.image_folder = data.product;
                        this.image_folder = data.product.image_folder;
                    }
                ).catch(err => console.log(err));
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
            validateNumbers(event) {
                let allowed = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'Backspace', '.'];
                if(allowed.indexOf(event.key) == -1) {
                    event.preventDefault();
                }
            },
            createVariant() {
                this.$Progress.start();
                this.form.post('/api/variant')
                .then((res) => {
                    Fire.$emit('AfterCreate');
                    this.form.reset();
                    this.describe_color = false;
                    this.product_images = [];
                    this.variant_images = [];
                    this.form.errors.clear();
                    Toast.fire({
                        icon: 'success',
                        title: 'New Product Variant Created!'
                    });
                    this.$Progress.finish();
                })
                .catch(
                    (err) => {
                        this.formErrors = err.response.data.errors;
                        this.$Progress.fail();
                        Toast.fire({
                            icon: 'error',
                            title: 'Something went wrong!'
                        });  
                    }
                )
            },
            resetForm() {
                this.form.reset();
            }
        },
        created() {
            this.loadProduct();
            Fire.$on('AfterCreate', () => {
                this.loadProduct();
            });
        },
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
