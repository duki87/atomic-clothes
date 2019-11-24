<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Product Brands</div>                           
                    <div class="card-body">
                        <button @click="newBrandModal" type="button" class="btn btn-secondary" data-toggle="modal" data-target="#brandModal">Add Brand</button>
                        <button @click="resetBrands()" type="button" class="btn btn-danger">Reset Brands</button>
                        <h3 class="mt-2">Manage Brands</h3>
                        <hr>
                        <!-- table with brands -->
                        <div class="table-responsive">
                            <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th class="th-sm">Title</th>
                                        <th class="th-sm text-center">Description</th>
                                        <th class="th-sm text-center">Logo</th>
                                        <th class="th-sm text-center">Website</th>
                                        <th class="th-sm text-center">Tags</th>
                                        <th class="th-sm text-center">Actions</th>
                                    </tr>                      
                                </thead>
                                <tbody>                                    
                                    <tr v-for="brand in brands.data" :key="brand.id">
                                        <td>{{brand.title}}</td>
                                        <td class="text-center">{{brand.description}}</td>
                                        <td class="text-center">
                                            <img v-if="brand.logo" :src="'/images/brandLogos/' + brand.logo" style="width:50px" alt="">
                                            <img v-else src="/images/brandLogos/no-logo.png" style="width:50px" alt="">
                                        </td>
                                        <td class="text-center">{{brand.website}}</td>
                                        <td class="text-center">
                                            <a v-for="(tag, index) in brand.tags" class="badge badge-default d-inline p-2 ml-2">
                                                {{tag}}
                                            </a>
                                        </td>
                                        <td class="text-center">
                                            <button @click="editBrandModal(brand)" class="btn btn-primary btn-sm"><i class="far fa-edit"></i></button>
                                            <button @click="deleteBrand(brand.id)" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i></button>                
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>   
                    <div class="card-footer">
                        <div class="float-right">
                            <pagination :data="brands" @pagination-change-page="getPage"></pagination>
                        </div>                  
                    </div>               
                </div>
            </div>
        </div>

        <!-- Modal: modalCart -->
        <div class="modal fade" id="brandModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <!--Header-->
            <div class="modal-header">
                <h4 v-show="!editMode" class="modal-title" id="myModalLabel">Add Brand</h4>
                <h4 v-show="editMode" class="modal-title" id="myModalLabel">Edit Brand</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <!--Body-->
            <form @submit.prevent="editMode? updateBrand() : createBrand()">
                <div class="modal-body">              
                    <div class="form-group">
                        <label for="title">Brand Title</label>
                        <input v-model="form.title" :class="{'is-invalid': form.errors.has('title')}" type="text" class="form-control" id="title" placeholder="Brand Title">
                        <div class="invalid-feedback">
                            <span v-for="err in formErrors.title">{{err}}</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="title">Brand Description</label>
                        <input v-model="form.description" :class="{'is-invalid': form.errors.has('description')}" type="text" class="form-control" id="description" placeholder="Brand Title">
                        <div class="invalid-feedback">
                            <span v-for="err in formErrors.description">{{err}}</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="title">Brand Website</label>
                        <input v-model="form.website" :class="{'is-invalid': form.errors.has('website')}" type="text" class="form-control" id="website" placeholder="Brand Website">
                        <div class="invalid-feedback">
                            <span v-for="err in formErrors.website">{{err}}</span>
                        </div>
                    </div>
                    <div class="md-form input-group mb-3">
                        <input type="text" v-model="brand_tag" @keyup.enter="addTag" class="form-control" 
                        id="add_tags" placeholder="Add Brand Tag and Press Enter">
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
                        <input :class="{'is-invalid': logoErrors.length > 0}" type="text" class="form-control" readonly id="" placeholder="Add Brand Logo">
                        <div class="input-group-append">
                            <button v-if="form.logo" @click="deleteLogo" class="btn btn-md btn-danger m-0 px-3" type="button" title="Delete Image"><i class="fas fa-trash"></i></button>
                            <button @click="$refs.fileInput.click()" class="btn btn-md btn-secondary m-0 px-3" type="button" title="Upload logo"><i class="fas fa-upload"></i></button>
                        </div>
                        <div class="invalid-feedback">
                            <span v-for="(err, index) in logoErrors">{{err}}</span>
                        </div>
                    </div>
                    <div class="input-group d-none">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="inputGroupFileAddon01">Brand Logo</span>
                        </div>
                        <div class="custom-file">
                            <input ref="fileInput" type="file" @change="uploadLogo" class="custom-file-input" id="image"
                            aria-describedby="inputGroupFileAddon01">
                            <label class="custom-file-label" for="image">Choose file</label>
                        </div>
                    </div>             
                    <div v-if="form.logo" class="p-2 d-flex justify-content-center" :class="[form.logo ? borderClass : '']">
                        <img v-if="editMode" class="" :src="'/images/brandLogos/' + form.logo" alt="" style="width:200px">
                        <img v-if="!editMode" class="" :src="form.logo" alt="" style="width:200px">
                    </div>           
                </div>
                <!--Footer-->
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-default" data-dismiss="modal">Close</button>
                    <button v-show="!editMode" type="submit" class="btn btn-default">Create</button>
                    <button v-show="editMode" type="submit" class="btn btn-default">Update</button>
                </div>
            </form>
            </div>
        </div>
        </div>
        <!-- Modal -->
    </div>
</template>

<script>
    export default {
        data() {
            return {
                form: new Form({
                    id: '',
                    title: '',
                    description: '',
                    logo: '',
                    website: '',
                    tags: []
                }),
                brand_tag: '',
                borderClass: 'border border-secondary',
                hoverBtn: undefined,
                brands: {},
                formErrors: {},
                editMode: false,
                image: '',
                logoErrors: [],
            }
        },
        methods: {
            createBrand() {
                this.$Progress.start();
                this.form.post('/api/brand')
                    .then(() => {
                        $('#brandModal').modal('hide');
                        Fire.$emit('AfterCreate');
                        this.form.reset();
                        this.form.errors.clear();
                        Toast.fire({
                            icon: 'success',
                            title: 'New Brand Created!'
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
            updateBrand() {
                this.$Progress.start();
                this.form.put('/api/brand/'+this.form.id)
                    .then(() => {
                        $('#brandModal').modal('hide');
                        Fire.$emit('AfterCreate');
                        this.form.reset();
                        this.form.errors.clear();
                        Toast.fire({
                            icon: 'success',
                            title: 'Brand Data Updated!'
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
            editBrandModal(brand) {
                this.editMode = true;
                this.form.reset();
                this.form.fill(brand);
                $('#brandModal').modal('show');
            },
            newBrandModal() {
                this.editMode = false;
                this.form.reset();
                $('#brandModal').modal('show');
            },
            addTag() {
                if(this.brand_tag !== '') {
                    this.form.tags.push(this.brand_tag);
                    this.brand_tag = '';
                }
            },
            removeTag(index) {
                this.form.tags.splice(index, 1);
            },
            isHovering(index) {
                return this.hoverBtn == index;
            },
            getBrands() {
                axios.get('/api/brand').then(
                    ({data}) => {
                        this.brands = data.brands;
                    }
                );
            },
            getPage(page = 1) {
                axios.get('/api/brands?page=' + page)
                    .then(response => {
                        this.brands = response.data.brands;
                    }
                );
            },
            deleteCategory(brandId) {
                Swal.fire({
                    title: 'Are you sure to delete this brand?',
                    text: 'All brand data will be deleted.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Delete'
                }).then((result) => {
                    this.$Progress.start();
                        if(result.value) {
                            this.form.delete('/api/brand/'+brandId)
                            .then(() => {
                            this.$Progress.finish();
                                Swal.fire(
                                    'Deleted!',
                                    'Brand has been deleted.',
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
                resetBrands() {
                    Swal.fire({
                        title: 'Are you sure about this?',
                        text: 'This will delete all brands from the database. You will have to add brands again.',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Delete'
                    }).then((result) => {
                        this.$Progress.start();
                        if(result.value) {
                            axios.get('/api/destroyBrands')
                            .then(() => {
                                this.$Progress.finish();
                                    Swal.fire(
                                        'All Brand Deleted!',
                                        'Now you can add fresh brand.',
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
                uploadLogo(event) {
                    this.form.logo = '';
                    this.logoErrors = '';
                    var file = event.target.files[0];
                    let reader = new FileReader();
                    reader.onloadend = (event) => {
                        this.form.logo = reader.result;
                    }
                    reader.readAsDataURL(file);
                    const config = {
                        headers: { 'content-type': 'multipart/form-data' }
                    }
                    let formData = new FormData();
                    formData.append('image', file);                 
                    axios.post('/api/validateImage', formData, config)
                    .then((response) => {                                     
                        console.log(response.data);
                    })
                    .catch((error) => {
                        this.form.logo = '';
                        this.logoErrors = error.response.data.errors.image;                   
                    })
                },
                deleteLogo() {
                    this.form.logo = '';
                    this.logoErrors = '';
                }
            },
        
            created() {
                this.getBrands();
                Fire.$on('AfterCreate', () => {
                    this.getBrands();
                });
            },

        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
