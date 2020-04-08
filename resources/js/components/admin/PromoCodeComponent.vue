<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Manage Promo Codes</div>
                    <div class="card-body">
                        <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#addPromoCodeModal">Add Code Series</button>
                        <button type="button" class="btn btn-default">Remove Code Series</button>
                        <h3 class="mt-2">List of all promo codes coupon series</h3>
                        <hr>
                        <div class="table-responsive">
                            <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th class="th-sm">Series/No of Coupons</th>
                                        <th class="th-sm text-center">Category</th>
                                        <th class="th-sm text-center">Brand</th>
                                        <th class="th-sm text-center">Discount</th>
                                        <th class="th-sm text-center">Start</th>
                                        <th class="th-sm text-center">Expire</th>
                                        <th class="th-sm text-center">Status</th>
                                        <th class="th-sm text-center">Actions</th>
                                    </tr>                      
                                </thead>
                                <tbody>                                    
                                    <tr v-for="(series, index) in promoCodes" :key="index">
                                        <td>{{ series[0].coupon_series }} / {{ series.length }}</td>
                                        <td>{{ series[0].category_id }}</td>
                                        <td>{{ series[0].brand_id }}</td>
                                        <td>{{ series[0].discount }}</td>
                                        <td>{{ series[0].start }}</td>
                                        <td>{{ series[0].expire }}</td>
                                        <td>{{ series[0].status }}</td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="float-right">
                            <pagination :data="promoCodes" @pagination-change-page="getPage"></pagination> 
                        </div>                  
                    </div>   
                </div>
            </div>
        </div>
        <add-promo-code></add-promo-code>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                form: new Form({
                    id: '',
                    code: '',
                    discount: '',
                    user_id: '',
                    category_id: '',
                    brand_id: '',
                    expire: Date
                }),
                formErrors: {},
                promoCodes: {}
            }          
        },
        methods: {
            loadPromoCodes() {
                axios.get('/api/promo-codes/')
                .then(
                ({data}) => {
                    this.promoCodes = data.promo_codes.data;                   
                })
                .catch((error) => console.log(error)); 
            },
            getPage(page = 1) {
                // this.currentPage = page;
                // axios.get('/api/product?page=' + page)
                //     .then(response => {
                //         this.products = response.data.products;
                //     }
                // );
            },
        },
        created() {
            this.loadPromoCodes();
        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>
