<template>
    <div v-if="ready" class="modal fade" id="couponsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
    aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Coupons (Promo Codes) in Series: {{ promoCodeSeriesDetails[0].coupon_series }}</h4>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th class="th-sm text-center">Coupon No.</th>
                                    <th class="th-sm text-center">User</th>
                                    <th class="th-sm text-center">Coupon Status</th>
                                    <th class="th-sm text-center">Remove</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(coupon, index) in promoCodeSeriesDetails" :key="index">
                                    <td class="text-center">{{ coupon.coupon_no }}</td>
                                    <td class="text-center">{{ coupon.user_id ? coupon.user_id : '/' }}</td>
                                    <td class="text-center">
                                        <span class="badge" :class="{ 'badge-light': coupon.status === 0, 'badge-success': coupon.status === 1 }">
                                            {{ coupon.status === 1 ? 'active' : 'used' }}
                                        </span>
                                    </td>
                                    <td class="text-center"><button class="btn btn-danger btn-sm" title="Remove Coupon"><i class="fas fa-trash-alt"></i></button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button @click="reset" type="button" class="btn btn-indigo" data-dismiss="modal"><i class="fas fa-paper-plane-o ml-1"></i> Close</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                promoCodeSeriesDetails: {},
                ready: false
            }
        },
        props: {
            promoCodeSeries: {}
        },
        created() {
            //console.log(this.promoCodeSeries);
        },
        methods: {
            reset() {
                this.ready = false;
                this.promoCodeSeriesDetails = {};
            }
        },
        watch: {
            promoCodeSeries: function(val) {
                this.ready = true;
                return this.promoCodeSeriesDetails = val;
            }
        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>