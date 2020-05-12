<template>
    <div class="container">
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
                                <div class="col-md-3">
                                    <label for="sku">SKU</label>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="sku">{{ product.code }}</span>
                                        </div>
                                        <input v-model="form.sku" :class="{'is-invalid': form.errors.has('sku')}" name="sku" type="text" class="form-control" id="sku" placeholder="SKU" aria-describedby="sku">
                                    </div>
                                    <div class="invalid-feedback">
                                        <span v-for="(err, index) in formErrors.sku" :key="index">{{ err }}</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="size">Select Color Variant</label>
                                    <select @change="loadColorVariantImages" v-model="form.color_id" name="color_id" id="color_id" :class="{'is-invalid': form.errors.has('color_id')}" class="custom-select browser-default">
                                        <option value="">Choose Color</option>
                                        <option v-for="(colorVariant, index) in product.colors" :key="index" :value="colorVariant.id">{{ colorVariant.color }}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="(err, index) in formErrors.color_id" :key="index">{{ err }}</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
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
                                        <span v-for="(err, index) in formErrors.sku" :key="index">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="title">Stock Quantity</label>
                                    <input type="text" v-model="form.stock" :class="{'is-invalid': form.errors.has('stock')}" @keypress="validateNumbers" class="form-control" id="stock" placeholder="Stock Quantity">
                                    <div class="invalid-feedback">
                                        <span v-if="formErrors.stock">{{formErrors.stock[0]}}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row mt-2 d-flex justify-content-around" v-if="color_variant_images" :class="[color_variant_images.length == 0 ? 'd-none' : '']">
                                <div class="col-md-12">
                                    <p>Images</p>
                                </div>
                                <div class="col-md-5 p-2" :class="borderClass">
                                    <img style="cursor:pointer; object-fit:cover; position:relative; width:30%; height:100px" class="ml-2 img-thumbnail" v-for="(imgObj, index) in color_variant_images" :key="index" alt="thumbnail" :src="'/images/products/' + image_folder + '/' + imgObj.image">
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
                                <a v-for="(tag, index) in form.tags" :key="index" 
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
                    id: Number,
                    product_id: Number,
                    sku: '',
                    color_id: Number,
                    size: '',
                    stock: 0,
                    tags: []
                }),
                formErrors: {},
                product: {},
                product_tag: '',
                borderClass: 'border border-secondary',
                hoverBtn: undefined,        
                formErrors: [],
                image_folder: '',
                color_variant_images: []
            }          
        },
        methods: {
            loadColorVariantImages() {
                if(this.form.color_id == '') {
                    return false;
                }
                axios.get('/api/color/'+this.form.color_id)
                    .then(
                        ({data}) => {
                            this.color_variant_images = data.colorVariant.color_variant_images;
                        }
                    )
                    .catch(err => console.log(err));
            },
            loadVariant() {
                let variant_id = this.$router.history.current.params.variant_id;
                axios.get('/api/variant/'+variant_id)
                    .then(
                        ({data}) => {  
                            this.form.fill(data.variant)
                            if(data.variant.tags) {
                                JSON.parse(data.variant.tags).forEach(tag => this.form.tags.push(tag));
                            }
                            this.product = data.variant.product;
                            if(data.variant.variant_color !== null) {
                                this.color_variant_images = data.variant.variant_color.color_variant_images;
                                this.image_folder = data.variant.product.image_folder;
                            }
                            this.image_folder = data.variant.product.image_folder;
                            this.variant_images = data.variant.variant_images;
                            this.product = data.variant.product;
                        }
                    )
                    .catch(err => console.log(err));
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
            //console.log('Component mounted.')
        }
    }
</script>
