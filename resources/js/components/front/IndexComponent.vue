<template>
    <div class="container">  
        Welcome!
    </div>
</template>

<script>
    export default {
        beforeCreate() {
            this.$root.$emit('CAROUSEL_SHOW', true);
        },
        mounted() {     
            this.$root.$emit('CAROUSEL_SHOW', true);
            //console.log('Component mounted.')
        }
    }
</script>
