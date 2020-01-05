<template>
    <div class="container">
        <!-- <router-view></router-view> -->
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Edit Product Variant</div> 
                    <form @submit.prevent="updateVariant">                          
                        <div class="card-body">             
                            <router-link to="{ name: 'product-variants', params: { id: form.product_id }}" type="button" class="btn btn-default" active-class="active" exact>All Product Variants</router-link>
                            <router-link to="/admin/products" type="button" class="btn btn-secondary" active-class="active" exact>All Products</router-link>
                            <h3 class="mt-2">Edit Product Variant Data</h3>
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
                                        <span v-if="formErrors.sku">{{formErrors.sku[0]}}</span>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <label for="color">
                                        <span v-if="!describe_color">Choose color from List</span>
                                        <span v-if="describe_color">Describe colors</span>
                                    </label>
                                    <div class="input-group">
                                        <select v-if="!describe_color" class="browser-default custom-select" v-model="form.color" name="color" id="color" :class="{'is-invalid': form.errors.has('color')}">
                                            <option value="">Select Color</option>
                                            <option v-for="color in colorsList" v-bind:value="color">{{color}}</option>
                                        </select>
                                        <input v-if="describe_color" :class="{'is-invalid': form.errors.has('size')}" type="text" class="form-control" v-model="form.color" id="color" placeholder="Describe Colors">
                                        <div class="invalid-feedback">
                                            <span v-if="formErrors.color">{{formErrors.color[0]}}</span>
                                        </div>
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
                                        <span v-if="formErrors.size">{{formErrors.size[0]}}</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="title">Stock Quantity</label>
                                    <input type="text" v-model="form.stock" :class="{'is-invalid': form.errors.has('stock')}" @keypress="validateNumbers" class="form-control" id="stock" placeholder="Stock Quantity">
                                    <div class="invalid-feedback">
                                        <span v-if="formErrors.stock">{{formErrors.stock[0]}}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row mt-2 d-flex justify-content-around" :class="[product_images.length < 1 || variant_images.length < 1 ? 'd-none' : '']">
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
                                id="add_tags" placeholder="Add Variant Tag and Press Enter">
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
                            <button type="submit" class="btn btn-default">Update</button>
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
                    id: '',
                    product_id: '',
                    sku: '',
                    color: '',
                    size: '',
                    stock: 0,
                    tags: [],
                    product: {},
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
            loadVariant() {
                let variant_id = this.$router.history.current.params.variant_id;
                axios.get('/api/variant/'+variant_id)
                .then(
                    ({data}) => {  
                        //this.form.fill(data.variant);
                        this.form.id = data.variant.id;
                        this.form.product_id = data.variant.product_id;
                        this.form.sku = data.variant.sku;
                        this.form.color = data.variant.color;
                        this.form.size = data.variant.size;
                        this.form.stock = data.variant.stock;
                        if(data.variant.tags) {
                            JSON.parse(data.variant.tags).forEach(tag => this.form.tags.push(tag));
                        }
                        this.form.product = data.variant;
                        data.variant.variant_images.forEach(image => this.form.variant_images.push(image.id));

                        if(this.colorsList.indexOf(this.form.color) == -1) {
                            this.describe_color = true;
                        }
                        this.image_folder = data.variant.product[0].image_folder;
                        this.variant_images = data.variant.variant_images;
                        this.product = data.variant.product[0];

                        for(let i=0; i<data.variant.product[0].product_images.length; i++) {
                            if(this.variant_images.map(function(image) { return image.image; }).indexOf(data.variant.product[0].product_images[i].image) == -1) {
                                this.product_images.push(data.variant.product[0].product_images[i]);
                            }
                        }

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
            updateVariant() {
                this.$Progress.start();
                this.form.put('/api/variant/'+this.form.id)
                .then((res) => {
/*                     this.form.reset();
                    let product_id = this.form.product_id;
                    this.describe_color = false;
                    this.product_images = [];
                    this.variant_images = [];
                    this.form.errors.clear(); 
                    console.log(product_id) */
                    this.$router.push({ name: 'product-variants', params: { id: this.form.product_id }});                               
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
            },
        },
        created() {
            this.loadVariant();
            Fire.$on('AfterCreate', () => {
                this.loadVariant();
            });
        },
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
