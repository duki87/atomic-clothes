<template>
    <!-- Modal -->
    <div class="modal fade" id="storeInfoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Store Info</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <img :src="'/images/stores/'+store.image" style="width:100%">
            <h2>{{ store.title }}</h2>
            <p>
                <strong>Address: </strong> {{ store.address }}
            </p>
            <p>
                <strong>Phone: </strong> {{ store.phone }}
            </p>
            <p>
                <a href="">Location</a>
            </p>
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
                store: {}
            }
        },
        props: ['storeInfo'],
        watch: {
            storeInfo: function(newValue, oldValue) {
                this.store = newValue;
            }
        },
        mounted() {
            //console.log('Component mounted.')
        }
    }
</script>
