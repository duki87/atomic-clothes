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
                <div class="md-form mb-5">
                    <i class="fas fa-barcode prefix grey-text"></i>
                    <input type="text" id="form3" class="form-control validate">
                    <label data-error="wrong" data-success="right" for="form3">Enter Code</label>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button class="btn btn-indigo">Send <i class="fas fa-paper-plane-o ml-1"></i></button>
            </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>