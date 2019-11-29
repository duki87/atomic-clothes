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
                            <div class="modal-body">              
                                <div class="form-group">
                                    <label for="title">Category Title</label>
                                    <input v-model="form.title" :class="{'is-invalid': form.errors.has('title')}" type="text" class="form-control" id="title" placeholder="Category Title">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.title">{{err}}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <select @change="loadSubCategories" v-model="form.main" name="main" id="main" :class="{'is-invalid': form.errors.has('main')}" class="custom-select browser-default">
                                        <option value="">Select Main Category</option>
                                        <option value="0">None</option>
                                        <option v-for="mainCat in mains" v-bind:value="mainCat.id" v-bind:selected="mainCat.id == form.main.id">{{mainCat.title}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.main">{{err}}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <select v-model="form.sub" name="sub" id="sub" class="custom-select browser-default" :class="{'is-invalid': form.errors.has('sub')}">
                                        <option value="">Select Sub Category</option>
                                        <option value="0">None</option>
                                        <option v-for="subCat in subs" v-bind:value="subCat.id" v-bind:selected="subCat.id == form.sub.id">{{subCat.title}}</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.sub">{{err}}</span>
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
                    category_id: '',
                    brand_id: '',
                    title: '',
                    description: '',
                    image_folder: '',
                    cover_image: '',
                    tags: '',
                    url: '',
                }),
                product_tag: '',
                borderClass: 'border border-secondary',
                hoverBtn: undefined,
                categories: {},
                mains: {},
                subs: {},
                formErrors: {},
            }          
        },
        methods: {
            createProduct() {

            },
            addTag() {
/*                 if(this.category_tag !== '') {
                    this.form.tags.push(this.category_tag);
                    this.category_tag = '';
                } */
            },
            removeTag(index) {
                /* this.form.tags.splice(index, 1); */
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
                if(this.form.main == 0) {
                    this.subs = {};
                } else {
                    axios.get('/api/loadSubCategories/'+this.form.main).then(
                    ({ data }) => {
                        this.subs = data.subCategories;
                        }
                    ).catch(e => console.log(e)); 
                }
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
