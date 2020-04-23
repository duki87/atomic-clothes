<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Add Product</div> 
                    <form @submit.prevent="updateProduct">                          
                        <div class="card-body">
<!--                             <button type="button" class="btn btn-secondary">Add Variant</button>
                            <button type="button" class="btn btn-danger">Delete Product</button> -->
                            <h3 class="mt-2">Enter Product Data</h3>
                            <hr>                                  
                            <div class="form-row">
                                <div class="col-md-4">
                                    <label for="title">Product Title</label>
                                    <input v-model="form.title" :class="{'is-invalid': form.errors.has('title')}" type="text" class="form-control" id="title" placeholder="Product Title">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.title" :key="err">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label for="title">Product Price</label>
                                    <input type="text" v-model="form.price" :class="{'is-invalid': form.errors.has('price')}" @keypress="validateNumbers" class="form-control" id="price" placeholder="Product Price">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.price" :key="err">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label for="title">Product Discount</label>
                                    <input v-model="form.discount" type="text" @keypress="validateNumbers" class="form-control" id="discount" placeholder="Product Discount">
                                </div>
                                <div class="col-md-4">
                                    <label for="title">Select Brand</label>
                                    <select v-model="form.brand_id" name="brand_id" id="brand_id" :class="{'is-invalid': form.errors.has('brand_id')}" class="custom-select browser-default">
                                        <option value="">Select Brand</option>
                                        <option v-for="(brand, index) in brands" :key="index" v-bind:value="brand.id" v-bind:selected="brand.id == form.brand_id">{{brand.title}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.brand_id"  :key="err">{{err}}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-4">
                                    <label for="title">Select Main Category</label>
                                    <select @change="loadSubCategories" v-model="form.main_category_id" name="main_category_id" id="main_category_id" :class="{'is-invalid': form.errors.has('main_category_id')}" class="custom-select browser-default">
                                        <option value="" selected>Select Main Category</option>
                                        <option v-for="[key, value] of Object.entries(mains)" v-bind:value="value" v-bind:selected="value == form.main_category_id"  :key="key">{{key}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.main_category_id"  :key="err">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="title">Select Sub Category</label>
                                    <select @change="loadCategories" v-model="form.sub_category_id" name="sub_category_id" id="sub_category_id" class="custom-select browser-default" :class="{'is-invalid': form.errors.has('sub_category_id')}">
                                        <option value="">Select Sub Category</option>
                                        <option v-for="[key, value] of Object.entries(subs)" v-bind:value="value" v-bind:selected="value == form.sub_category_id"  :key="key">{{key}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.sub_category_id"  :key="err">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="title">Select Category</label>
                                    <select v-model="form.category_id" name="category_id" id="category_id" class="custom-select browser-default" :class="{'is-invalid': form.errors.has('category_id')}">
                                        <option value="">Select Sub Category</option>
                                        <option v-for="[key, value] of Object.entries(categories)" v-bind:value="value" v-bind:selected="value == form.category_id"  :key="key">{{key}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.category_id"  :key="err">{{err}}</span>
                                    </div>
                                </div>
                            </div>     
                            <div class="md-form mb-4 pink-textarea active-pink-textarea-2">
                                <i class="fas fa-pencil-alt prefix"></i>
                                <textarea id="description" v-model="form.description" class="md-textarea form-control" rows="3"></textarea>
                                <label for="form23">Enter Product Description</label>
                            </div>   
                            <div class="md-form input-group mb-3">
                                <input type="text" v-model="product_tag" @keyup.enter="addTag" class="form-control" 
                                id="add_tags" placeholder="Add Product Tag and Press Enter">
                                <div class="input-group-append">
                                    <button @click="addTag" class="btn btn-md btn-secondary m-0 px-3" type="button" >Add</button>
                                </div>
                            </div>          
                            <div class="p-2" :class="[form.tags.length > 0 ? borderClass : '']">
                                <a v-for="(tag, index) in form.tags"  :key="index" 
                                @click="removeTag(index)" @mouseover="hoverBtn = index" @mouseout="hoverBtn = undefined" 
                                :class="[isHovering(index) ? 'badge badge-danger' : 'badge badge-default']" class=" d-inline p-2 ml-2">
                                    {{tag}}
                                </a>                       
                            </div> 
                            <div class="md-form input-group mb-3">
                                <input :class="{'is-invalid': coverErrors.length > 0}" type="text" class="form-control" readonly id="" placeholder="Add Images">
                                <div class="input-group-append">
                                    <button v-if="images.length > 0" @click="deleteImages" class="btn btn-md btn-danger m-0 px-3" type="button" title="Delete Images">Delete All Images <i class="fas fa-trash"></i></button>
                                    <button @click="$refs.fileInput.click()" class="btn btn-md btn-secondary m-0 px-3" type="button" title="Upload Image"><i class="fas fa-upload"></i></button>
                                </div>
                                <div class="invalid-feedback">
                                    <span v-for="(err, index) in coverErrors"  :key="index">{{err}}</span>
                                </div>
                            </div>
                            <div class="input-group d-none">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="inputGroupFileAddon01">Images</span>
                                </div>
                                <div class="custom-file">
                                    <input ref="fileInput" type="file" multiple @change="uploadImages" class="custom-file-input" name="image[]" id="image"
                                    aria-describedby="inputGroupFileAddon01">
                                    <label class="custom-file-label" for="image">Choose Files</label>
                                </div>
                            </div> 
                            <div v-if="images.length > 0" class="p-2 d-flex justify-content-around" style="display: flex;flex-wrap: wrap; padding-left: 0;" :class="[images.length > 0 ? borderClass : '']">
                                <div style="position:relative; width:20%; max-height:200px;" class="ml-2 mt-2" v-for="(imgObj, index) in images"  :key="index" :class="{'cover-image': form.cover_image == imgObj.name}">
                                    <img @click="selectCover" alt="thumbnail" class="img-thumbnail" :src="'/images/products/' + form.image_folder + '/' + imgObj.name" :data-imgname="imgObj.name" style="object-fit:cover;width:100%;height:100%;">
                                    <button type="button" @click.prevent="deleteImage(imgObj)" :data-imgId="imgObj.id" class="close close-button" style="color: red"><span aria-hidden="true">&times;</span></button>
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
                    id: 0,
                    main_category_id: '',
                    sub_category_id: '',
                    category_id: '',
                    brand_id: '',
                    title: '',
                    description: '',
                    price: '',
                    discount: '',
                    image_folder: '',
                    cover_image: '',
                    tags: [],
                    status: 0
                }),
                product_tag: '',
                borderClass: 'border border-secondary',
                hoverBtn: undefined,        
                mains: {},
                subs: {},
                categories: {},
                brands: {},
                formErrors: {},
                editMode: false,
                image: '',
                coverErrors: [],
                product_tag: '',
                images: [],
                imageData: undefined
            }          
        },
        methods: {
            createProduct() {
                this.form.post('/api/product')
                .then((res) => {
                    this.form.id = res.data.product_id;
                    this.form.image_folder = res.data.image_folder;
                })
                .catch(
                    (err) => {
                        Toast.fire({
                            icon: 'error',
                            title: 'Something went wrong!'
                        });  
                    }
                )
            },
            updateProduct() {
                this.$Progress.start();
                if(this.formErrors) {
                    this.$Progress.fail();
                }
                this.$Progress.start();
                this.form.put('/api/product/'+this.form.id)
                .then((res) => {
                    this.$Progress.finish(); 
                    this.form.status = 1;
                    this.$router.push({ name: 'product-variants', params: { id: this.form.id }});
                })
                .catch(
                    (err) => {
                        this.formErrors = err.response.data.errors;
                        this.$Progress.fail();
                    }
                )
            },
            selectCover(event) {
                this.form.cover_image = event.target.dataset.imgname;
            },
            deleteImage(imgObj) {
                if(imgObj.name == this.form.cover_image) {
                    this.form.cover_image = '';
                }  
                this.images.splice(this.images.indexOf(imgObj), 1);   
                axios.get('/api/destroyProductImage/'+imgObj.id)
                .then((response) => {       
                    this.$Progress.finish();                                    
                    Toast.fire({
                        icon: 'success',
                        title: 'Image Deleted!'
                    });                       
                })
                .catch((error) => {
                   Toast.fire({
                        icon: 'danger',
                        title: 'Something went wrong!'
                    });  
                    this.$Progress.fail();                
                })
            },
            deleteImages() {
                this.form.cover_image = '';
                this.images = [];
                this.imageData = undefined;
                axios.get('/api/destroyProductImages/'+this.form.id)
                .then((response) => {       
                    this.$Progress.finish();                                    
                    Toast.fire({
                        icon: 'success',
                        title: 'All Images Deleted!'
                    });                       
                })
                .catch((error) => {
                   Toast.fire({
                        icon: 'error',
                        title: 'Something went wrong!'
                    });  
                    this.$Progress.fail();                
                })
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
            loadMainCategories() {
                axios.get('/api/loadCategories/main/0').then(
                ({ data }) => {
                    this.mains = data.main;
                    }
                ).catch(e => console.log(e)); 
            },
            loadSubCategories() {
                if(this.form.main_category_id == '') {
                    this.subs = {};
                    this.categories = {};
                    this.form.category_id = '';
                    this.form.sub_category_id = '';                    
                } else {
                    axios.get('/api/loadCategories/sub/'+this.form.main_category_id).then(
                    ({ data }) => {
                        this.subs = data.sub;
                        }
                    ).catch(e => console.log(e)); 
                }
            },
            loadCategories() {
                if(this.form.sub_category_id == '') {
                    this.form.category_id = '';
                    this.categories = {};
                } else {
                    axios.get('/api/loadCategories/category/'+this.form.sub_category_id).then(
                    ({ data }) => {
                        this.categories = data.category;
                    }).catch(e => console.log(e)); 
                }
            },
            loadBrands() {
                axios.get('/api/loadBrands').then(
                ({ data }) => {
                    this.brands = data.brands;        
                }).catch((error) => console.log(error)); 
            },
            uploadImages(event) {                
                this.imageData = new FormData();
                Array.from(event.target.files).forEach(
                    file => {
                        this.imageData.append('images[]', file);  
                    }
                ); 
                if(this.form.image_folder !== '') {
                    this.imageData.append('directory', this.form.image_folder);  
                }
                this.imageData.append('product_id', this.form.id);
                this.$Progress.start();
                const config = {
                    headers: { 'content-type': 'multipart/form-data' }
                }                                                                
                axios.post('/api/uploadProductImages', this.imageData, config)
                .then((response) => {       
                    this.$Progress.finish(); 
                    Object.keys(response.data.images).forEach(key => {
                        this.images.push(response.data.images[key]);
                    });             
                    this.form.cover_image = response.data.images[0].name;                       
                    this.imageData = undefined;
                    this.form.image_folder = response.data.directory;
                    Toast.fire({
                        icon: 'success',
                        title: 'Images Uploaded!'
                    });                       
                })
                .catch((error) => {
                   Toast.fire({
                        icon: 'error',
                        title: 'Allowed file types are .jpg, .png, .jpeg. Maximum file size is 10 Mb.'
                    });  
                    this.$Progress.fail();                
                })
            },
            validateNumbers(event) {
                let allowed = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'Backspace', '.'];
                if(allowed.indexOf(event.key) == -1) {
                    event.preventDefault();
                }
            },
            resetForm() {
                Swal.fire({
                    title: 'Are you sure to reset all product data?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Delete',
                    onClose: this.cancelProgress 
                }).then((result) => {
                    this.$Progress.start();
                        if(result.value) {
                            this.form.delete('/api/product/'+this.form.id)
                            .then(() => {
                                this.$Progress.finish();
                                this.$router.go();
                            }).catch(
                                () => {
                                    this.$Progress.fail();
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Error',
                                        text: 'There was an error!'
                                    })
                                }
                            );
                        }
                }).catch(
                    console.log('error')
                )
            },
            cancelProgress() {
                this.$Progress.finish();
            },
            deleteProduct() {
                this.form.delete('/api/product/'+this.form.id)
                .then(() => {
                    console.log('product deleted')
                }).catch(
                    (err) => {
                        console.log(err)
                    }
                );
            },
            onClose() {
                alert('closing...')
            }
        },
        created() {
            this.createProduct();
            this.loadMainCategories();            
            this.loadBrands();
        },
        beforeDestroy() {
            if(this.form.status == 0) {         
                this.deleteProduct();
            } 
        },
        mounted() { 
            console.log('Component mounted.');
        }
    }
</script>
