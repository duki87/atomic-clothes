<template>
    <div class="container">

        <!--Navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark mdb-color lighten-3 mt-3 mb-5">

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
                <li class="nav-item active">
                <a class="nav-link" href="#">Featured
                    <span class="sr-only">(current)</span>
                </a>
                </li>
                <li v-for="(category, index) in collection"  :key="index" class="nav-item" >
                    <router-link :to="{ name: 'front-category', params: { category: category.url }}" class="nav-link waves-effect" tag="a" active-class="active" exact>
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
                console.log(params.collection)
                axios.get('/api/getCollection/'+params.collection).then(
                ({ data }) => {
                        console.log(data)
                        this.collection = data.collection;
                    }
                ).catch(e => console.log(e)); 
            },
        },
        created() {
            this.loadCollection();
        },      
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
