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
                        <tr v-for="(colorVariant, index) in product.colors" :key="index" style="cursor:pointer">
                            <td class="th-sm">{{ colorVariant.color }}</td>
                            <td class="th-sm text-center">{{ colorVariant.color_variant_images.length > 0 ? colorVariant.color_variant_images.length+' images' : 'No Images' }} </td>
                            <td class="th-sm text-center">
                                <button @click="deleteColorVariant(colorVariant)" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i></button>
                                <router-link :to="{ name: 'edit-color-variant', params: { id: product.id }}" class="btn btn-primary btn-sm" exact><i class="far fa-edit"></i></router-link>   
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <router-link :to="{ name: 'add-color-variant', params: { id: product.id }}" class="btn btn-primary">Add Color Variant</router-link>   
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
                colorVariantForm: new Form({
                    id: Number,
                    product_id: String,
                    color: String,
                }),
                describe_color: false,
                colorsList: ['Red', 'Blue', 'Green', 'Pink', 'Purple', 'White', 'Black', 'Grey'],
                formErrors: {},
                product: {},
                borderClass: 'border border-secondary',
                hoverBtn: undefined,        
                formErrors: {},
                color_variant_images: [],
                image_folder: ''
            }          
        },
        methods: {
            loadColorVariant(productId) {
                axios.get(`/api/getProductColorVariants/${productId}`).then(
                    ({data}) => {
                        this.product = data.product;
                    }
                );
            },
        },
        props: {
            product_id: ''
        },
        watch: {
            product_id: function(newVal, oldVal) { 
                // watch it
                //console.log('Prop changed: ', newVal, ' | was: ', oldVal);
                this.loadColorVariant(newVal);
            }
        },
        created() {

        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>
