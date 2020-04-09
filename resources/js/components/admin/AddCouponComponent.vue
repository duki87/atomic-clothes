<template>
    <div class="modal fade" id="addPromoCodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
    aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Add Promo Code Series</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form @submit.prevent="createPromoCode">
                    <div class="modal-body">                   
                            <div>
                                <label for="number_of_codes">Number of Codes in Series</label>
                                <div class="input-group mb-3">
                                    <input v-model="form.number_of_codes" :class="{'is-invalid': form.errors.has('number_of_codes')}" type="number" min="1" step="1" class="form-control" id="sku" placeholder="Number of Codes in Series" aria-describedby="number_of_codes">
                                </div>
                                <div class="invalid-feedback">
                                    <span v-for="(err, index) in formErrors.number_of_codes" :key="index">{{err}}</span>
                                </div>
                            </div>
                            <div>
                                <label for="discount">Discount</label>
                                <div class="input-group mb-3">
                                    <input v-model="form.discount" :class="{'is-invalid': form.errors.has('discount')}" type="number" min="1" max="100" step="1" class="form-control" id="sku" placeholder="Discount in %" aria-describedby="discount">
                                </div>
                                <div class="invalid-feedback">
                                    <span v-for="(err, index) in formErrors.discount" :key="index">{{err}}</span>
                                </div>
                            </div>
                            <div>
                                <label for="discount">Discount Only for Brand</label>
                                <select v-model="form.brand_id" name="brand_id" id="brand_id" :class="{'is-invalid': form.errors.has('brand_id')}" class="custom-select browser-default">
                                    <option value="">All</option>
                                    <option v-for="(brand, index) in brands" :key="index" :value="brand.id">{{ brand.title }}</option>
                                </select>
                                <div class="invalid-feedback">
                                    <span v-for="(err, index) in formErrors.brand_id" :key="index">{{err}}</span>
                                </div>
                            </div>
                            <div>
                                <label for="discount">Discount Only for Category</label>
                                <select v-model="form.category_id" name="category_id" id="category_id" :class="{'is-invalid': form.errors.has('category_id')}" class="custom-select browser-default">
                                    <option value="">All</option>
                                    <option v-for="(category, index) in categories" :key="index" :value="category.id">{{ category.title }}</option>
                                </select>
                                <div class="invalid-feedback">
                                    <span v-for="(err, index) in formErrors.category_id" :key="index">{{err}}</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="discount">Promo Code Start Date</label>
                                    <div class="datetimepicker">
                                        <div class="datetimepicker-inputs">
                                            <datetime type="datetime" v-model="form.start"></datetime>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="discount">Promo Code Expire Date</label>
                                    <div class="datetimepicker">
                                        <div class="datetimepicker-inputs">
                                            <datetime type="datetime" v-model="form.expire"></datetime>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        
                    </div>
                    <div class="modal-footer d-flex justify-content-center">
                        <button class="btn btn-indigo" type="submit">Create <i class="fas fa-paper-plane-o ml-1"></i></button>
                    </div>
                </form>
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
                    discount: '',
                    user_id: '',
                    category_id: '',
                    brand_id: '',
                    start: Date.now().toString(), 
                    expire: Date.now().toString(),
                    number_of_codes: 1
                }),
                formErrors: {},
                categories: {},
                brands: {},
            }
        },
        methods: {
            createPromoCode() {
                this.form.post('/api/promo-codes')
                .then((res) => {
                    this.form.reset();
                    $('#addPromoCodeModal').modal('hide');
                    this.$emit('couponCreated', 'NEW_COUPON');
                })
                .catch((error) => {
                    console.log(error);
                })
            },
            loadCategories() {
                axios.get('/api/loadAllCategories')
                .then((res) => {
                    this.categories = res.data.categories;
                })
                .catch((error) => {
                    console.log(error);
                })
            },
            loadBrands() {
                axios.get('/api/loadBrands')
                .then((res) => {
                    this.brands = res.data.brands;
                })
                .catch((error) => {
                    console.log(error);
                })
            },
        },
        created() {
            this.loadCategories();
            this.loadBrands();
        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>