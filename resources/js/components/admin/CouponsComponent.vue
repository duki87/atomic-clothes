<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Manage Promo Codes</div>
                    <div class="card-body">
                        <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#addPromoCodeModal">Add Code Series</button>
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
                                        <th class="th-sm text-center">Start/Expire</th>
                                        <th class="th-sm text-center">Actions</th>
                                    </tr>                      
                                </thead>
                                <tbody>                                    
                                    <tr v-for="(series, index) in promoCodes.data" :key="index">
                                        <td class="text-center">{{ series[0].coupon_series }} / {{ series.length }}</td>
                                        <td class="text-center">{{ series[0].category_id ? series[0].category_id : '/' }}</td>
                                        <td class="text-center">{{ series[0].brand_id ? series[0].brand_id : '/' }}</td>
                                        <td class="text-center">{{ series[0].discount }}</td>
                                        <td class="text-center">{{ series[0].start }} /<br>{{ series[0].expire }}</td>
                                        <td class="text-center">
                                            <button @click="deleteSeries(series[0].coupon_series)" class="btn btn-danger btn-sm" title="Remove Series"><i class="fas fa-trash-alt"></i></button>                
                                            <button @click="selectPromoCodeSeries(series)" type="button" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#couponsModal"><i class="fas fa-eye"></i></button>
                                        </td>                                       
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
        <add-promo-code v-on:couponCreated="couponCreated($event)"></add-promo-code>
        <promo-codes-list v-bind:promoCodeSeries="promoCodeSeries"></promo-codes-list>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                promoCodes: {},
                currentPage: 1,
                promoCodeSeries: {}
            }          
        },
        methods: {
            loadPromoCodes() {
                axios.get('/api/promo-codes/')
                .then(
                ({data}) => {
                    this.promoCodes = data.coupons;                   
                })
                .catch((error) => {
                    console.log(error);
                }); 
            },
            getPage(page = 1) {
                this.currentPage = page;
                axios.get('/api/promo-codes?page=' + page)
                .then(({data}) => {
                    this.promoCodes = data.coupons;
                })
                .catch((error) => {
                    console.log(error);
                });
            },
            selectPromoCodeSeries(series) {
                return this.promoCodeSeries = series;
            },
            deleteSeries(series) {
                axios.delete(`/api/promo-codes/${series}`)
                .then((res) => {
                    this.loadPromoCodes();
                })
                .catch((error) => {
                    console.log(error);
                });
            },
            couponCreated(couponCreated) {
                this.loadPromoCodes();
            }
        },
        created() {
            this.loadPromoCodes();
        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>
