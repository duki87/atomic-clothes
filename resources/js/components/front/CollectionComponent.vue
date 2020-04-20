<template>
    <div>
        <div class="container" style="margin-top:65px;">
            <div class="col-md-12 mb-4 mx-auto"> 
                <!--Navbar-->
                <nav class="navbar navbar-expand-lg navbar-dark mdb-color lighten-3 mt-3 mb-2">
                    <!-- Navbar brand -->
                    <span class="navbar-brand">Categories:</span>
                    <!-- Collapse button -->
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#basicExampleNav"
                    aria-controls="basicExampleNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <!-- Collapsible content -->
                    <div class="collapse navbar-collapse" id="basicExampleNav">
                        <!-- Links -->
                        <ul class="navbar-nav mr-auto">
                            <!-- <li class="nav-item active" :class="{ 'active': $route.params.category === 'all' }">
                                <router-link :to="{ name: 'front-category', params: { category: '' }}" class="nav-link active waves-effect" tag="a" exact>
                                    Featured
                                </router-link>
                            </li> -->
                            <li v-for="(category, index) in collection" :key="index" class="nav-item" :class="{ 'active': $route.params.category === category.url }">
                                <router-link :to="{ name: 'front-category', params: { category: category.url }}" 
                                :class="{ 'active': $route.params.category === category.url }" class="nav-link waves-effect" tag="a" exact>
                                    {{ category.title }}
                                </router-link>
                            </li>
                        </ul>
                        <!-- Links -->
                        <form class="form-inline">
                            <div class="md-form my-0">
                                <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
                            </div>
                        </form>
                    </div>
                    <!-- Collapsible content -->
                </nav>
                <!--/.Navbar-->
                <router-view></router-view>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                collection: {}
            }
        },
        methods: {
            loadCollection() {
                let params = this.$route.params;
                axios.get('/api/getCollection/'+params.collection).then(
                ({ data }) => {
                        this.collection = data.collection;
                    }
                ).catch((error) => {
                    console.log(error);
                }); 
            },
        },
        created() {
            this.loadCollection();
        },      
        mounted() {
            this.$root.$emit('CAROUSEL_SHOW', false);
            //console.log('Component mounted.')
        }
    }
</script>
