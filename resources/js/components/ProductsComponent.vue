<template>
    <div class="container">
        <!-- <router-view></router-view> -->
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Products List</div>                           
                    <div class="card-body">
                        <button type="button" class="btn btn-secondary">Add Product</button>
                        <h3 class="mt-2">Manage Variants</h3>
                        <hr>
                        <!-- table with brands -->
                        <div class="table-responsive">
                            <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th class="th-sm">Title</th>
                                        <th class="th-sm text-center">Main Cat.</th>
                                        <th class="th-sm text-center">Sub Cat.</th>
                                        <th class="th-sm text-center">Category</th>
                                        <th class="th-sm text-center">Cover</th>
                                        <th class="th-sm text-center">Tags</th>
                                        <th class="th-sm text-center">Variants</th>
                                        <th class="th-sm text-center">Actions</th>
                                    </tr>                      
                                </thead>
                                <tbody>                                    
                                    <tr v-for="product in products.data" :key="product.id"> 
                                        <td class="text-center">{{product.title}}</td> 
                                        <td class="text-center">{{product.mainCatTitle}}</td> 
                                        <td class="text-center">{{product.subCatTitle}}</td>
                                        <td class="text-center">{{product.catTitle}}</td>
                                        <td class="text-center">
                                            <img src="" alt="">
                                        </td>
                                        <td class="text-center align-middle">
                                            <a v-for="(tag, index) in product.tags" class="badge badge-default d-inline p-2 ml-2">
                                                {{tag}}
                                            </a>
                                        </td>
                                        <td class="text-center">
                                            <router-link :to="{ name: 'product-variants', params: { id: product.id }}" class="btn btn-success btn-sm" exact>Edit Variants</router-link>
                                        </td>
                                        <td class="text-center">
                                            <router-link :to="{ name: 'product', params: { id: product.id }}" class="btn btn-primary btn-sm" exact><i class="far fa-edit"></i></router-link>
                                            <button @click="deleteProduct(product)" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i></button>                
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>   
                    <div class="card-footer">
                        <div class="float-right">
                            <pagination :data="products" @pagination-change-page="getPage"></pagination> 
                        </div>                  
                    </div>               
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
                    price: '',
                    discount: '',
                    image_folder: '',
                    cover_image: '',
                    tags: []
                }),
                products: {}
            }
        },
        methods: {
            loadProducts() {
                axios.get('/api/product').then(
                ({ data }) => {
                    this.products = data.products;
                    }
                ).catch(e => console.log(e)); 
            },
            deleteProduct(product) {
                this.form.reset();
                this.form.fill(product);
                Swal.fire({
                    title: 'Are you sure to delete this product?',
                    text: 'Deleting product also deletes related product variants.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Delete',
                    onClose: this.cancelProgress 
                }).then((result) => {
                    this.$Progress.start();
                        if(result.value) {
                            this.form.delete('/api/product/'+product.id)
                            .then(() => {
                                this.$Progress.finish();
                                Swal.fire(
                                    'Deleted!',
                                    'Product has been deleted.',
                                    'success'
                                );
                                this.form.reset();
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
            cancelProgress() {
                this.form.reset();
                this.$Progress.finish();
            },
            getPage(page = 1) {
                this.currentPage = page;
                axios.get('/api/product?page=' + page)
                    .then(response => {
                        this.products = response.data.products;
                    }
                );
            },
        },
        created() {        
            this.loadProducts();
            Fire.$on('AfterCreate', () => {
                this.getProducts();
            });
        },
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>