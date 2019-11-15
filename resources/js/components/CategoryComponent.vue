<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Product Categories</div>                           
                    <div class="card-body">
                        <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#addCatModal">Add Category</button>
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
                                        <td class="text-center">{{category.main}}</td>
                                        <td class="text-center">{{category.sub}}</td>
                                        <td class="text-center">{{category.tags}}</td>
                                        <td class="text-center">
                                            <button class="btn btn-primary btn-sm"><i class="far fa-edit"></i></button>
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
        <div class="modal fade" id="addCatModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <!--Header-->
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Add Category</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <!--Body-->
            <form @submit.prevent="createCategory">
                <div class="modal-body">              
                    <div class="form-group">
                        <div class="">
                            <label for="title">Category Title</label>
                            <input v-model="form.title" :class="{'is-valid': form.errors.has('title')}" type="text" class="form-control" id="title" placeholder="Category Title" required>
                            <div class="invalid-feedback">Example invalid custom select feedback</div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="">
                            <select @change="loadSubCategories" v-model="form.main" name="main" id="main" class="custom-select browser-default" required>
                                <option value="">Select Main Category</option>
                                <option value="0">Main Category</option>
                                <option v-for="mainCat in mains" v-bind:value="mainCat.id">{{mainCat.title}}</option>
                            </select>
                            <div class="invalid-feedback">Category title is required!</div>
                            <!-- <has-error :form="form" :field="title"></has-error> -->
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="">
                            <select v-model="form.sub" name="sub" id="sub" class="custom-select browser-default" required>
                                <option value="">Select Sub Category</option>
                                <option value="0">Sub Category</option>
                                <option v-for="subCat in subs" v-bind:value="subCat.id">{{subCat.title}}</option>
                            </select>
                            <div class="invalid-feedback">Example invalid custom select feedback</div>
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
                        <a v-for="(tag, index) in form.tags" 
                        @click="removeTag(index)" @mouseover="hoverBtn = index" @mouseout="hoverBtn = undefined" 
                        :class="[isHovering(index) ? 'badge badge-danger' : 'badge badge-default']" class=" d-inline p-2 ml-2">
                            {{tag}}
                        </a>                       
                    </div>           
                </div>
                <!--Footer-->
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-default">Save</button>
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
                subs: {}
            }
        },
        methods: {
            createCategory() {
                this.$Progress.start();
                this.form.post('/api/category')
                    .then(() => {
                        $('#addCatModal').modal('hide');
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
                        () => {this.$Progress.fail();}
                    );
            },
            addTag() {
                this.form.tags.push(this.category_tag);
                this.category_tag = '';
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
            getPage(page = 1) {
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
                text: 'You can always add same category again.',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Delete'
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
                            type: 'error',
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
