<template>
    <div class="container">
        <!-- <router-view></router-view> -->
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Product Variants</div>                           
                    <div class="card-body">
                        <router-link :to="{ name: 'add-variant', params: { id: product_id }}" class="btn btn-secondary" tag="a">
                            Add Another Variant
                        </router-link>
                        <button type="button" class="btn btn-default">Back to Products</button>
                        <h3 class="mt-2">Variant List for Products</h3>
                        <hr>
                        <!-- table -->
                        <div class="table-responsive">
                            <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th class="th-sm">SKU</th>
                                        <th class="th-sm text-center">Color</th>
                                        <th class="th-sm text-center">Size</th>
                                        <th class="th-sm text-center">Stock</th>
                                        <th class="th-sm text-center">Images</th>
                                        <th class="th-sm text-center">Tags</th>
                                        <th class="th-sm text-center">Actions</th>
                                    </tr>                      
                                </thead>
                                <tbody>                                    
                                    <tr v-for="variant in variants.data" :key="variant.id"> 
                                        <td class="text-center">{{ variant.sku }}</td> 
                                        <td class="text-center">{{ variant.variant_color == null ? '' : variant.variant_color.color }}</td> 
                                        <td class="text-center">{{ variant.size }}</td>
                                        <td class="text-center">{{ variant.stock }}</td>
                                        <td class="text-center">
                                            <button v-if="variant.variant_color !== null" type="button" class="btn btn-secondary btn-sm" data-toggle="modal" @click="onModalShow(variant)" data-target="#imagesModal" data-backdrop="true">View</button>
                                        </td>
                                        <td class="text-center align-middle">
                                            <a v-for="(tag, index) in variant.tags" :key="index" class="badge badge-default d-inline p-2 ml-2">
                                                {{ tag }}
                                            </a>
                                        </td>
                                        <td class="text-center">
                                            <router-link :to="{ name: 'edit-variant', params: { id: variant.product.id, variant_id: variant.id }}" class="btn btn-primary btn-sm" exact><i class="far fa-edit"></i></router-link>
                                            <button @click="deleteVariant(variant)" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i></button>                
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>   
                    <div class="card-footer">
                        <div class="float-right">
                            <pagination :data="variants" @pagination-change-page="getPage"></pagination> 
                        </div>                  
                    </div>               
                </div>
            </div>
        </div>

        <!-- Frame Modal Bottom -->
        <div v-clickOutside="onModalHide" class="modal fade bottom" id="imagesModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
            <!-- Add class .modal-frame and then add class .modal-bottom (or other classes from list above) to set a position to the modal -->
            <div class="modal-dialog modal-frame modal-bottom" role="document">
                <div class="modal-header">
                    Images for this product variant
                </div>
                <div class="modal-content">
                    <div class="modal-body" v-if="variant_images" style="overflow-x: scroll !important; height: 250px">
                        <img style="cursor:pointer; object-fit:cover; position:relative; width:30%; height:200px" class="ml-2 img-thumbnail" v-for="(imgObj, index) in variant_images" :key="index" alt="thumbnail" :src="'/images/products/' + image_folder + '/' + imgObj.image" :data-index="index">
                    </div>
                </div>
            </div>
        </div>
        <!-- Frame Modal Bottom -->
    </div>
</template>

<script>
    export default {
        data() {
            return {
                form: new Form({
                    id: '',
                    sku: '',
                    color_id: '',
                    size: '',
                    stock: 0,
                    tags: [],
                }),
                variants: {},
                variant_images: [],
                image_folder: '',
                product_id: ''
            }
        },
        methods: {
            loadVariants() {
                axios.get(`/api/getVariantsByProductId/${this.product_id}`).then(
                ({ data }) => {
                    console.log(data.variants)
                    this.variants = data.variants;                   
                }).catch(e => console.log(e)); 
            },
            deleteVariant(variant) {
                this.form.reset();
                this.form.fill(variant);
                Swal.fire({
                    title: 'Are you sure to delete this product variant?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Delete',
                    onClose: this.cancelProgress 
                }).then((result) => {
                    this.$Progress.start();
                        if(result.value) {
                            this.form.delete('/api/variant/'+variant.id)
                            .then((data) => {
                                this.$Progress.finish();
                                console.log(data)
                                Swal.fire(
                                    'Deleted!',
                                    'Product Variant has been deleted.',
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
                }).catch((error) => {
                    console.log(error);
                })
            },
            cancelProgress() {
                this.form.reset();
                this.$Progress.finish();
            },
            getPage(page = 1) {
                this.currentPage = page;
                axios.get('/api/getVariantsByProductId/'+this.product_id+'?page=' + page)
                    .then(response => {
                        this.variants = response.data.variants;
                    }
                );
            },
            onModalHide() {
                this.variant_images = '';
                this.image_folder = '';
            },
            onModalShow(variant) {
                this.variant_images = [];
                if(variant.variant_color !== null) {
                    this.variant_images = variant.variant_color.color_variant_images;
                    this.image_folder = variant.product.image_folder;
                }
            }
        },
        created() {        
            console.log(this.$router.history.current.params.id)
            this.product_id = this.$router.history.current.params.id;
            this.loadVariants();
            Fire.$on('AfterCreate', () => {
                this.loadVariants();
            });
        },
        directives: {
            clickOutside: {
                bind: function (el, binding, vnode) {
                    event = function (event) {
                        if((el == event.target || el.contains(event.target) || event.target.className === "modal fade bottom" || event.target.className === "modal fade bottom" )) {
                            vnode.context[binding.expression](event);
                        }
                    };
                    document.body.addEventListener('click', event);
                },
                unbind: function (el) {
                    document.body.removeEventListener('click', event);
                },
            }
        },
        watch: {

        },
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>