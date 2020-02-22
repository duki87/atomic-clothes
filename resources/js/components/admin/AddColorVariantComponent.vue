<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Add Product Color Variant</div> 
                    <form @submit.prevent="createColorVariant">                          
                        <div class="card-body">             
                            <router-link to="/admin/products" type="button" class="btn btn-secondary" active-class="active" exact>All Products</router-link>
                            <h3 class="mt-2">Enter Data</h3>
                            <hr>                                  
                            <div class="form-row">
                                <div class="col-md-8">
                                    <label for="color">
                                        <span v-if="!describe_color">Choose Color from List</span>
                                        <span v-if="describe_color">Describe Colors</span>
                                    </label>
                                    <div class="input-group">
                                        <select v-if="!describe_color" class="browser-default custom-select" v-model="form.color" name="color" id="color" :class="{'is-invalid': form.errors.has('color')}">
                                            <option value="">Select Color</option>
                                            <option v-for="(color, index) in colorsList" :key="index" v-bind:value="color">{{color}}</option>
                                        </select>
                                        <input v-if="describe_color" type="text" class="form-control" v-model="form.color" id="color" placeholder="Describe Colors" :class="{'is-invalid': form.errors.has('color')}">
                                        <div class="input-group-append">
                                            <button @click="changeColorInput" class="btn btn-md btn-secondary m-0 px-3 py-2 z-depth-0 waves-effect" type="button">
                                                <span v-if="describe_color">Choose Color from List</span>
                                                <span v-if="!describe_color">Describe Colors</span>
                                            </button>
                                        </div>
                                        <div class="invalid-feedback">
                                            <span v-for="(err, index) in formErrors.color" :key="index">{{err}}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row mt-2 d-flex justify-content-around" :class="[product_images.length === 0 ? 'd-none' : '']">
                                <div class="col-md-12">
                                    <p>Add Images To Product Variant</p>
                                </div>
                                <div class="col-md-5 p-2" :class="borderClass">
                                    <img style="cursor:pointer; object-fit:cover; position:relative; width:30%; height:100px" class="ml-2 img-thumbnail" v-for="(imgObj, index) in product_images" :key="index" alt="thumbnail" @click="addToColorVariantsImg(index)" :src="'/images/products/' + image_folder + '/' + imgObj.image" :data-index="index">
                                </div>
                                <div class="col-md-5 p-2" :class="borderClass">
                                    <img style="cursor:pointer; object-fit:cover; position:relative; width:30%; height:100px" class="ml-2 img-thumbnail" v-for="(imgObj, index) in color_variant_images" :key="index" alt="thumbnail" @click="addToProductsImg(index)" :src="'/images/products/' + image_folder + '/' + imgObj.image" :data-index="index">
                                </div>
                            </div>

                            <div class="md-form input-group mb-3">
                                <div class="col-md-12">
                                    <p>Or Upload More Images</p>
                                </div>
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
                    id: Number,
                    product_id: Number,
                    color: String,
                    color_variant_images: []
                }),
                describe_color: false,
                colorsList: ['Red', 'Blue', 'Green', 'Pink', 'Purple', 'White', 'Black', 'Grey'],
                formErrors: {},
                product: {},
                borderClass: 'border border-secondary',
                hoverBtn: undefined,        
                formErrors: {},
                color_variant_images: [],
                product_images: [],
                image_folder: ''
            }          
        },
        methods: {
            loadProduct() {
                let product_id = this.$router.history.current.params.id;
                this.form.product_id = product_id;
                axios.get('/api/product/'+product_id)
                .then(
                    ({data}) => {
                        let product_images = data.product.product_images.filter(this.filterImages)
                        this.product_images = product_images;
                        this.product = data.product;
                        this.image_folder = data.product.image_folder;
                    }
                ).catch(err => console.log(err));
            },
            filterImages(image) {
                return image.color_id == 0;
            },
            addToProductsImg(index) {
                let imgObj = this.color_variant_images[index];
                this.form.color_variant_images.splice(this.form.color_variant_images.indexOf(imgObj.id), 1);
                this.product_images.push(imgObj);
                this.color_variant_images.splice(index, 1);
            },
            addToColorVariantsImg(index) {
                let imgObj = this.product_images[index];
                this.form.color_variant_images.push(imgObj.id);
                this.color_variant_images.push(imgObj);
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
            createColorVariant() {
                this.$Progress.start();
                this.form.post('/api/color')
                .then((res) => {
                    this.form.reset();
                    this.describe_color = false;
                    this.product_images = [];
                    this.color_variant_images = [];
                    this.form.errors.clear();
                    Toast.fire({
                        icon: 'success',
                        title: 'New Product Color Created!'
                    });
                    this.$Progress.finish();
                    this.loadProduct();
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
            this.loadProduct();
        },
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>