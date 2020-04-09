<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Product Categories</div>                           
                    <div class="card-body">
                        <button @click="newCategoryModal" type="button" class="btn btn-secondary" data-toggle="modal" data-target="#categoryModal">Add Category</button>
                        <button @click="resetCategories()" type="button" class="btn btn-danger">Reset Categories</button>
                        <h3 class="mt-2">Manage Categories</h3>
                        <hr>
                        <!-- table with categories -->
                        <div class="table-responsive">
                            <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th class="th-sm">Title</th>
                                        <th class="th-sm text-center">Main Category</th>
                                        <th class="th-sm text-center">Sub Category</th>
                                        <th class="th-sm text-center">Tags</th>
                                        <th class="th-sm text-center">Actions</th>
                                    </tr>                      
                                </thead>
                                <tbody>
                                    <tr v-for="category in categories.data" :key="category.id">
                                        <td>{{category.title}}</td>
                                        <td class="text-center">{{category.mainTitle}}</td>
                                        <td class="text-center">{{category.subTitle}}</td>
                                        <td class="text-center">
                                            <a v-for="(tag, index) in category.tags" :key="index" class="badge badge-default d-inline p-2 ml-2">
                                                {{tag}}
                                            </a>
                                        </td>
                                        <td class="text-center">
                                            <button @click="editCategoryModal(category)" class="btn btn-primary btn-sm"><i class="far fa-edit"></i></button>
                                            <button @click="deleteCategory(category.id)" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i></button>                
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>   
                    <div class="card-footer">
                        <div class="float-right">
                            <pagination :data="categories" @pagination-change-page="getPage"></pagination>
                        </div>                  
                    </div>               
                </div>
            </div>
        </div>

        <!-- Modal: modalCart -->
        <div @click="detectClick" @keydown.esc="getPage(currentPage)" class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                <!--Header-->
                <div class="modal-header">
                    <h4 v-show="!editMode" class="modal-title" id="myModalLabel">Add Category</h4>
                    <h4 v-show="editMode" class="modal-title" id="myModalLabel">Edit Category</h4>
                    <button @click="getPage(currentPage)" type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <!--Body-->
                <form @submit.prevent="editMode? updateCategory() : createCategory()">
                    <div class="modal-body">              
                        <div class="form-group">
                            <label for="title">Category Title</label>
                            <input v-model="form.title" :class="{'is-invalid': form.errors.has('title')}" type="text" class="form-control" id="title" placeholder="Category Title">
                            <div class="invalid-feedback">
                                <span v-for="(err, index) in formErrors.title" :key="index">{{err}}</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <select @change="loadSubCategories" v-model="form.main" name="main" id="main" :class="{'is-invalid': form.errors.has('main')}" class="custom-select browser-default">
                                <option value="">Select Main Category</option>
                                <option value="0">None</option>
                                <option v-for="(mainCat, index) in mains" :key="index" v-bind:value="mainCat.id" v-bind:selected="mainCat.id == form.main.id">{{mainCat.title}}</option>
                            </select>
                            <div class="invalid-feedback">
                                <span v-for="(err, index) in formErrors.main" :key="index">{{err}}</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <select v-model="form.sub" name="sub" id="sub" class="custom-select browser-default" :class="{'is-invalid': form.errors.has('sub')}">
                                <option value="">Select Sub Category</option>
                                <option value="0">None</option>
                                <option v-for="[key, value] of Object.entries(subs)" v-bind:value="value" :key="value" v-bind:selected="value == form.sub.id">{{key}}</option>
                            </select>
                            <div class="invalid-feedback">
                                <span v-for="(err, index) in formErrors.sub" :key="index">{{err}}</span>
                            </div>
                        </div>  
                        <div class="md-form input-group mb-3">
                            <input type="text" v-model="category_tag" @keyup.enter="addTag" class="form-control" 
                            id="add_tags" placeholder="Add Category Tag and Press Enter">
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
                    <!--Footer-->
                    <div class="modal-footer">
                        <button @click="getPage(currentPage)" type="button" class="btn btn-outline-default" data-dismiss="modal">Close</button>
                        <button v-show="!editMode" type="submit" class="btn btn-default">Create</button>
                        <button v-show="editMode" type="submit" class="btn btn-default">Update</button>
                    </div>
                </form>
                </div>
            </div>
        </div>
        <!-- Modal: modalCart -->
    </div>
</template>

<script>
    export default {
        data() {
            return {
                form: new Form({
                    id: '',
                    title: '',
                    main: '',
                    sub: '',
                    tags: []
                }),
                category_tag: '',
                borderClass: 'border border-secondary',
                hoverBtn: undefined,
                categories: {},
                mains: {},
                subs: {},
                formErrors: {},
                editMode: false,
                currentPage: 1
            }
        },
        methods: {
            createCategory() {
                this.$Progress.start();
                this.form.post('/api/category')
                    .then(() => {
                        $('#categoryModal').modal('hide');
                        Fire.$emit('AfterCreate');
                        this.form.reset();
                        this.form.errors.clear();
                        Toast.fire({
                            icon: 'success',
                            title: 'New Category Created!'
                        });
                        this.$Progress.finish();
                    })
                    .catch(
                        (err) => {
                            this.formErrors = err.response.data.errors;
                            this.$Progress.fail();
                        }
                    );
            },
            updateCategory() {
                this.$Progress.start();
                this.form.put('/api/category/'+this.form.id)
                    .then(() => {
                        $('#categoryModal').modal('hide');
                        Fire.$emit('AfterCreate');
                        this.form.reset();
                        this.form.errors.clear();
                        Toast.fire({
                            icon: 'success',
                            title: 'Category Data Updated!'
                        });
                        this.$Progress.finish();
                    })
                    .catch(
                        (err) => {
                            this.formErrors = err.response.data.errors;
                            this.$Progress.fail();
                        }
                    );
            },
            editCategoryModal(category) {
                this.editMode = true;
                this.form.reset();
                this.form.fill(category);
                $('#categoryModal').modal('show');
            },
            newCategoryModal() {
                this.editMode = false;
                this.form.reset();
                $('#categoryModal').modal('show');
            },
            addTag() {
                if(this.category_tag !== '') {
                    this.form.tags.push(this.category_tag);
                    this.category_tag = '';
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
                if(this.form.main == '' || this.form.main == 0) {
                    this.subs = {};
                    this.form.sub = '';
                } else {
                    axios.get('/api/loadCategories/sub/'+this.form.main).then(
                    ({ data }) => {
                        this.subs = data.sub;
                        }
                    ).catch(e => console.log(e)); 
                }
            },
            getPage(page = 1) {
                this.currentPage = page;
                axios.get('/api/category?page=' + page)
                    .then(response => {
                        this.categories = response.data.categories;
                        this.mains = response.data.mains;
                    }
                );
            },
            deleteCategory(categoryId) {
                Swal.fire({
                    title: 'Are you sure to delete this category?',
                    text: 'Deleting main or subcategory also deletes related categories.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Delete',
                    onClose: this.cancelProgress 
                }).then((result) => {
                    this.$Progress.start();
                        if(result.value) {
                            this.form.delete('/api/category/'+categoryId)
                            .then(() => {
                            this.$Progress.finish();
                                Swal.fire(
                                    'Deleted!',
                                    'Category has been deleted.',
                                    'success'
                                );
                                Fire.$emit('AfterCreate');
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
                resetCategories() {
                    Swal.fire({
                        title: 'Are you sure about this?',
                        text: 'This will delete all categories from the database. You will have to add categories again.',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Delete',
                        onClose: this.cancelProgress
                    }).then((result) => {
                        this.$Progress.start();
                        if(result.value) {
                            axios.get('/api/destroyCategories')
                            .then(() => {
                                this.$Progress.finish();
                                    Swal.fire(
                                        'All Categories Deleted!',
                                        'Now you can add fresh categories.',
                                        'success'
                                    );
                                    Fire.$emit('AfterCreate');
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
                    )
                },
                cancelProgress() {
                    this.$Progress.finish();
                },
                detectClick(event) {
                    if(event.target.id == 'categoryModal') {
                        this.getPage(this.currentPage);
                    }
                }
        },     
        created() {
            this.getCategories();
            Fire.$on('AfterCreate', () => {
                this.getCategories();
            });
        },

        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
