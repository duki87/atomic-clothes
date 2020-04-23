<template>
    <div class="modal fade" id="promoCodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
    aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Promo Code</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <label data-error="wrong" data-success="right" for="form3">Enter Code (Example: UWSF000377-01)</label>
                    <div class="input-group">                                        
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-barcode prefix grey-text"></i></span>
                        </div>
                        <input v-model="coupon_series" min="10" max="10" type="text" class="form-control">
                        <input v-model="coupon_no" min="2" type="text" @keypress="validateNumbers" class="form-control">                                            
                    </div>
                    <small v-if="code_valid.valid" class="text-danger">This code is not valid. Please try another one.</small>  
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button class="btn btn-indigo" @click="checkPromoCode">Use Code <i class="fas fa-paper-plane-o ml-1"></i></button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                coupon_series: '',
                coupon_no: '',
                code_valid: {valid: false, message: ''},
            }
        },
        methods: {
            checkPromoCode() {
                return axios.post('/api/promo-codes/check', {coupon_series: this.coupon_series, coupon_no: this.coupon_no})
                .then((res) => {
                    $('#promoCodeModal').modal('hide');
                    this.$emit('couponApplied', res.data.promo_code);
                    console.log(res);
                })
                .catch((error) => {
                    console.log(error);
                });
            },
            validateNumbers(event) {
                let allowed = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'Backspace'];
                if(allowed.indexOf(event.key) == -1) {
                    event.preventDefault();
                }
            },
        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>