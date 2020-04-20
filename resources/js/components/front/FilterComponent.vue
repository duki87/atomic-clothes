<template>
    <div class="mt-0 mb-2 row">
        <div class="col-md-6">
            <h4 class="d-inline">Filter Products</h4>
        </div>
        <div class="col-md-6">
            <div class="float-right">
                <!--Filter by Category-->
                <div class="d-inline">
                    <button class="btn btn-sm btn-default dropdown-toggle mt-0 ml-0" type="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">{{ filterTitles['category'] }}</button>
                    <div class="dropdown-menu">
                        <a v-for="(category, index) in filters.categories" :key="index" @click="createFilters('category', category.id, category.title)" class="dropdown-item">{{ category.title }}</a>
                    </div>
                </div>
                <!-- Filter by Category -->
                <!--Filter by Brand-->
                <div class="d-inline">
                    <button class="btn btn-sm btn-default dropdown-toggle mt-0 ml-0" type="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">{{ filterTitles['brand'] }}</button>
                    <div class="dropdown-menu">
                        <a v-for="(brand, index) in filters.brands" :key="index" @click="createFilters('brand', brand.id, brand.title)" class="dropdown-item">{{ brand.title }}</a>
                    </div>
                </div>
                <!-- Filter by Brand -->
                <!--Filter by Color-->
                <div class="d-inline">
                    <button class="btn btn-sm btn-default dropdown-toggle mt-0 ml-0" type="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">{{ filterTitles['color'] }}</button>
                    <div class="dropdown-menu">
                        <a v-for="(color, index) in filters.colors" :key="index" @click="createFilters('color', color.color, color.color)" class="dropdown-item">{{ color.color }}</a>
                    </div>
                </div>
                <!-- Filter by Color -->
                <!-- Cancel filters -->
                <div v-if="filterApplied" class="d-inline">
                   <button @click="cancelFilters" style="width:60px" class="btn btn-sm btn-outline-danger mt-0 ml-0" title="Cancel Filters" type="button">
                        <i class="fas fa-times"></i>   
                    </button> 
                </div>
                <!-- Cancel filters -->
            </div>
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
                    color: ''
                },
                filterTitles: {
                    brand: 'Brand',
                    category: 'Category',
                    color: 'Color'
                },
                filterApplied: false
            }
        },
        props: {
            filters: {}
        },
        methods: {
            createFilters(filter, param, title) {
                this.filterApplied = true;
                this.selectedFilters[filter] = param;
                this.filterTitles[filter] = title;
                this.$emit('filtersEmit', this.selectedFilters);
            },
            cancelFilters() {
                this.selectedFilters = { category: Number, brand: Number, color: '' };
                this.filterTitles = { category: 'Category', brand: 'Brand', color: 'Color' };
                this.filterApplied = false;
                this.$emit('filtersEmit', 'all');
            }
        },
        created() {
           //console.log(this.filters);
        },
        mounted() {
            this.$root.$emit('CAROUSEL_SHOW', false);
            //console.log('Component mounted.');
        }
    }
</script>