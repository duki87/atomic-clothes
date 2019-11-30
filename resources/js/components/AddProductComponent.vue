<template>
    <div class="container">
        <!-- <router-view></router-view> -->
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Add Product</div> 
                    <form @submit.prevent="createProduct">                          
                        <div class="card-body">
                            <button type="button" class="btn btn-secondary">Add Variant</button>
                            <button type="button" class="btn btn-danger">Delete Product</button>
                            <h3 class="mt-2">Enter Product Data</h3>
                            <hr>                                  
                            <div class="form-row">
                                <div class="col-md-6">
                                    <label for="title">Product Title</label>
                                    <input v-model="form.title" :class="{'is-invalid': form.errors.has('title')}" type="text" class="form-control" id="title" placeholder="Product Title">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.title">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="title">Select Brand</label>
                                    <select v-model="form.brand_id" name="brand_id" id="brand_id" :class="{'is-invalid': form.errors.has('brand_id')}" class="custom-select browser-default">
                                        <option value="">Select Brand</option>
                                        <option v-for="brand in brands" v-bind:value="brand.id" v-bind:selected="brand.id == form.brand_id">{{brand.title}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.brand_id">{{err}}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-4">
                                    <label for="title">Select Main Category</label>
                                    <select @change="loadSubCategories" v-model="form.main" name="main_category_id" id="main_category_id" :class="{'is-invalid': form.errors.has('main_category_id')}" class="custom-select browser-default">
                                        <option value="" selected>Select Main Category</option>
                                        <option v-for="mainCat in mains" v-bind:value="mainCat.id" v-bind:selected="mainCat.id == form.main_category_id">{{mainCat.title}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.main_category_id">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="title">Select Sub Category</label>
                                    <select @change="loadCategories" vv-model="form.sub" name="sub_category_id" id="sub_category_id" class="custom-select browser-default" :class="{'is-invalid': form.errors.has('sub_category_id')}">
                                        <option value="">Select Sub Category</option>
                                        <option v-for="subCat in subs" v-bind:value="subCat.id" v-bind:selected="subCat.id == form.sub_category_id">{{subCat.title}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.sub_category_id">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="title">Select Category</label>
                                    <select v-model="form.sub" name="category_id" id="category_id" class="custom-select browser-default" :class="{'is-invalid': form.errors.has('category_id')}">
                                        <option value="">Select Sub Category</option>
                                        <option value="0">None</option>
                                        <option v-for="subCat in subs" v-bind:value="subCat.id" v-bind:selected="subCat.id == form.category_id">{{subCat.title}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.category_id">{{err}}</span>
                                    </div>
                                </div>
                            </div>     
                            <div class="md-form mb-4 pink-textarea active-pink-textarea-2">
                                <i class="fas fa-pencil-alt prefix"></i>
                                <textarea id="form23" class="md-textarea form-control" rows="3"></textarea>
                                <label for="form23">Enter Product Description</label>
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
                            <div class="md-form input-group mb-3">
                                <input :class="{'is-invalid': coverErrors.length > 0}" type="text" class="form-control" readonly id="" placeholder="Add Cover Image">
                                <div class="input-group-append">
                                    <button v-if="form.cover_image" @click="deleteCover" class="btn btn-md btn-danger m-0 px-3" type="button" title="Delete Image"><i class="fas fa-trash"></i></button>
                                    <button @click="$refs.fileInput.click()" class="btn btn-md btn-secondary m-0 px-3" type="button" title="Upload Image"><i class="fas fa-upload"></i></button>
                                </div>
                                <div class="invalid-feedback">
                                    <span v-for="(err, index) in coverErrors">{{err}}</span>
                                </div>
                            </div>
                            <div class="input-group d-none">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="inputGroupFileAddon01">Brand Logo</span>
                                </div>
                                <div class="custom-file">
                                    <input ref="fileInput" type="file" @change="uploadCover" class="custom-file-input" id="image"
                                    aria-describedby="inputGroupFileAddon01">
                                    <label class="custom-file-label" for="image">Choose file</label>
                                </div>
                            </div> 
                            <div v-if="form.cover_image" class="p-2 d-flex justify-content-center" :class="[form.cover_image ? borderClass : '']">
                                <img class="" :src="image" alt="" style="width:200px">
                            </div> 
                        </div>   
                        <div class="card-footer">
                            <button type="button" class="btn btn-outline-default">Reset</button>
                            <button type="submit" class="btn btn-default">Create</button>                                 
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
                    main_category_id: '',
                    sub_category_id: '',
                    category_id: '',
                    brand_id: '',
                    title: '',
                    description: '',
                    image_folder: '',
                    cover_image: '',
                    tags: []
                }),
                product_tag: '',
                borderClass: 'border border-secondary',
                hoverBtn: undefined,
                categories: {},
                mains: {},
                subs: {},
                brands: {},
                formErrors: {},
                editMode: false,
                image: '',
                coverErrors: [],
                currentPage: 1,
                product_tag: ''
            }          
        },
        methods: {
            createProduct() {

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
            getCategories() {
                axios.get('/api/category').then(
                    ({data}) => {
                        this.categories = data.categories;
                        this.mains = data.mains;
                    }
                );
            },
            loadSubCategories() {
                //console.log(this.form.main)
                if(this.form.main_category_id == 0) {
                    this.subs = {};
                } else {
                    axios.get('/api/loadSubCategories/'+this.form.main_category_id).then(
                    ({ data }) => {
                        this.subs = data.subCategories;
                        }
                    ).catch(e => console.log(e)); 
                }
            },
            loadCategories() {

            },
            uploadCover(event) {
                this.form.cover_image = '';
                this.coverErrors = '';
                var file = event.target.files[0];
                let reader = new FileReader();
                reader.onloadend = (event) => {
                    this.form.cover_image = reader.result;
                    this.image = reader.result;
                }
                reader.readAsDataURL(file);
                const config = {
                    headers: { 'content-type': 'multipart/form-data' }
                }
                let formData = new FormData();
                formData.append('image', file);                 
                axios.post('/api/validateCoverImage', formData, config)
                .then((response) => {                                     
                    console.log(response.data);
                })
                .catch((error) => {
                    this.form.cover_image = '';
                    this.image = '';
                    this.coverErrors = error.response.data.errors.image;                   
                })
            },
            deleteCover() {
                if(this.editMode) {
                    axios.get('/api/destroyCover/'+this.form.id).then(
                        ({result}) => {
                            console.log(result.message);
                        }
                    );
                }
                this.image = '';
                this.form.cover_image = '';
                this.coverErrors = '';
            },
        },
        created() {
            this.getCategories();
        },
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
