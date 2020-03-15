<template>
    <div class="mb-4">
        <div class="d-inline mt-4">
            <h4 class="d-inline">Filter Products</h4>
        </div>
        <div class="float-right">
            <!--Filter by Category-->
            <div class="d-inline">
                <button class="btn btn-sm btn-default dropdown-toggle mt-0 mr-2" type="button" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false">Category</button>
                <div class="dropdown-menu">
                    <a v-for="(category, index) in filters.categories" :key="index" @click="createFilters('category', category.id)" class="dropdown-item">{{ category.title }}</a>
                </div>
            </div>
            <!-- Filter by Category -->
            <!--Filter by Brand-->
            <div class="d-inline">
                <button class="btn btn-sm btn-default dropdown-toggle mt-0 mr-2" type="button" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false">Brand</button>
                <div class="dropdown-menu">
                    <a v-for="(brand, index) in filters.brands" :key="index" @click="createFilters('brand', brand.id)" class="dropdown-item">{{ brand.title }}</a>
                </div>
            </div>
            <!-- Filter by Brand -->
            <!--Filter by Color-->
            <div class="d-inline">
                <button class="btn btn-sm btn-default dropdown-toggle mt-0 mr-2" type="button" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false">Color</button>
                <div class="dropdown-menu">
                    <a v-for="(color, index) in filters.colors" :key="index" @click="createFilters('color', color.id)" class="dropdown-item">{{ color.color }}</a>
                </div>
            </div>
            <!-- Filter by Color -->
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                selectedFilters: {
                    category: Number,
                    brand: Number,
                    color: Number
                }
            }
        },
        props: {
            filters: {}
        },
        methods: {
            createFilters(filter, value) {
                this.selectedFilters[filter] = parseInt(value);
                this.$emit('filtersEmit', this.selectedFilters);
            },
        },
        created() {
           console.log(this.filters);
        },
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>