<template>
    <div class="container">
        <!-- <router-view></router-view> -->
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Product NAME</div>                           
                    <div class="card-body">
                        <button type="button" class="btn btn-secondary">Add Variant</button>
                        <button type="button" class="btn btn-danger">Reset Variants</button>
                        <h3 class="mt-2">Manage Variants</h3>
                        <hr>
                        <!-- table with brands -->
                        <div class="table-responsive">
                            <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th class="th-sm">Title</th>
                                        <th class="th-sm text-center">Description</th>
                                        <th class="th-sm text-center">Logo</th>
                                        <th class="th-sm text-center">Website</th>
                                        <th class="th-sm text-center">Tags</th>
                                        <th class="th-sm text-center">Actions</th>
                                    </tr>                      
                                </thead>
                                <tbody>                                    

                                </tbody>
                            </table>
                        </div>
                    </div>   
                    <div class="card-footer">
                        <div class="float-right">
                            <!-- <pagination :data="brands" @pagination-change-page="getPage"></pagination> -->
                        </div>                  
                    </div>               
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                form: new Form({
/*                     id: '',
                    title: '',
                    description: '',
                    logo: '',
                    website: '',
                    tags: [] */
                }),
                currentPage: 1
            }
        },
        methods: {

        },

        mounted() {
            console.log('Component mounted.')
        }
    }
</script>