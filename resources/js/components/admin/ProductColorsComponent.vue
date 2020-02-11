<template>
    <!-- Modal -->
    <div class="modal fade" id="colorsModal" tabindex="-1" role="dialog" aria-labelledby="colorsModal"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th class="th-sm">Color</th>
                            <th class="th-sm text-center">Images</th>
                            <th class="th-sm text-center">Delete</th>
                        </tr>                      
                    </thead>
                    <tbody>
                        <tr v-for="(colorVariant, index) in colorVariants" :key="index" style="cursor:pointer">
                            <td class="th-sm">{{ colorVariant.color }}</td>
                            <td class="th-sm text-center">{{ colorVariant.color_variant_images.length > 0 ? colorVariant.color_variant_images.length+' images' : 'No Images' }} </td>
                            <td class="th-sm text-center">
                                <button @click="deleteColorVariant(colorVariant)" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i></button>
                                <router-link :to="{ name: 'edit-color-variant', params: { id: colorVariant.product_id }}" class="btn btn-primary btn-sm" exact><i class="far fa-edit"></i></router-link>   
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">  
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
                    id: '',
                    product_id: '',
                    color: ''
                }),
                colorVariants: [],      
                formErrors: {},
                color_variant_images: [],
                image_folder: ''
            }          
        },
        methods: {
            loadColorVariants(productId) {
                axios.get(`/api/getProductColorVariants/${productId}`).then(
                    ({data}) => {
                        this.colorVariants = data.colorVariants;
                    }
                );
            },
            deleteColorVariant(colorVariant) {
                //console.log(colorVariant)
                this.form.reset()
                this.form.fill(colorVariant)
                Swal.fire({
                    title: 'Are you sure to delete this product color?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Delete',
                    onClose: this.cancelProgress 
                }).then((result) => {
                    this.$Progress.start();
                        if(result.value) {
                            this.form.delete('/api/color/'+colorVariant.id)
                            .then((data) => {
                                this.$Progress.finish();
                                Swal.fire(
                                    'Deleted!',
                                    'Product Variant has been deleted.',
                                    'success'
                                );
                                this.form.reset();
                                this.loadColorVariants(this.product_id);
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
            }
        },
        props: {
            product_id: ''
        },
        watch: {
            product_id: function(newVal, oldVal) { 
                // watch it
                //console.log('Prop changed: ', newVal, ' | was: ', oldVal);
                this.loadColorVariants(newVal);
            }
        },
        created() {

        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>
