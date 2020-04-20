<template>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">Add Store</div> 
                    <form @submit.prevent="createStore">
                        <div class="card-body">
                            <div id="add-store-map" style="width:100%; height: 400px"></div>
                            <h3 class="mt-2">Enter Store Data</h3>
                            <p>Click on map or enter address to add store location.</p>
                            <div class="form-row">
                                <div class="col-md-6">
                                    <label for="title">Store Title</label>
                                    <input v-model="form.title" :class="{'is-invalid': form.errors.has('title')}" type="text" class="form-control" id="title" placeholder="Store Title">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.title" :key="err">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="title">Store Manager</label>
                                    <input v-model="form.manager" :class="{'is-invalid': form.errors.has('manager')}" type="text" class="form-control" id="manager" placeholder="Store Manager Name">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.manager" :key="err">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="md-form input-group">
                                        <input :class="{'is-invalid': imageErrors.length > 0}" type="text" class="form-control" readonly id="" placeholder="Add Store Image">
                                        <div class="input-group-append">
                                            <button v-if="form.image" @click="deleteImage" class="btn btn-md btn-danger m-0 px-3" type="button" title="Delete Image"><i class="fas fa-trash"></i></button>
                                            <button @click="$refs.fileInput.click()" class="btn btn-md btn-secondary m-0 px-3" type="button" title="Upload Image"><i class="fas fa-upload"></i></button>
                                        </div>
                                        <div class="invalid-feedback">
                                            <span v-for="(err, index) in imageErrors" :key="index">{{err}}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="title">Store Address</label>
                                    <input v-model="form.address" :class="{'is-invalid': form.errors.has('address')}" type="text" class="form-control" id="address" placeholder="Store Full Address">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.address" :key="err">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="title">City</label>
                                    <input v-model="form.city" :class="{'is-invalid': form.errors.has('city')}" type="text" class="form-control" id="city" placeholder="City">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.city" :key="err">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="title">Phone</label>
                                    <input v-model="form.phone" :class="{'is-invalid': form.errors.has('phone')}" type="text" class="form-control" id="phone" placeholder="Store Phone Number">
                                    <div class="invalid-feedback">
                                        <span v-for="err in formErrors.phone" :key="err">{{err}}</span>
                                    </div>
                                </div>
                                <div class="col-md-12 mt-2">
                                    <div class="input-group d-none">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="inputGroupFileAddon01">Store Image</span>
                                        </div>
                                        <div class="custom-file">
                                            <input ref="fileInput" type="file" @change="uploadImage" class="custom-file-input" id="image"
                                            aria-describedby="inputGroupFileAddon01">
                                            <label class="custom-file-label" for="image">Choose file</label>
                                        </div>
                                    </div>
                                    <div v-if="form.image" class="p-2 d-flex justify-content-center" :class="[form.image ? borderClass : '']">
                                        <img class="" :src="image" alt="" style="width:200px">
                                    </div> 
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button type="submit" class="btn btn-default">Create</button>
                            <button type="button" class="btn btn-outline-default" @click="resetForm">Reset</button>                             
                        </div>
                    </form> 
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
                    id: '',
                    title: '',
                    city: '',
                    address: '',
                    phone: '',
                    latitude: '',
                    longitude: '',
                    manager: '',
                    image: ''
                }),
                imageErrors: [],
                borderClass: 'border border-secondary',
                geocoder: '',
                image: '',
                formErrors: {},
                token: 'pk.eyJ1IjoiZHVraTg3IiwiYSI6ImNrNHp5NmNqYjBjOG4za21peXdkbHFldWwifQ.pmTnS8cOoO9bFXWnWu1-5A',
                addStoreMap: {},
                canvas: {},
                marker: null,
                geojson: {
                    'type': 'FeatureCollection',
                    'features': [
                        {
                            'type': 'Feature',
                            'geometry': {
                                'type': 'Point',
                                'coordinates': [-80.21127912958411, 25.772579267751652]
                            }
                        }
                    ]
                },
                style: 'mapbox://styles/mapbox/streets-v11'
            }              
        },
        methods: {
            createStore() {
                this.$Progress.start();
                this.form.post('/api/store')
                .then((res) => {
                    this.$Progress.finish(); 
                    this.createControlls();
                    this.resetForm();
                })
                .catch(
                    (err) => {
                        this.$Progress.fail();
                        Toast.fire({
                            icon: 'error',
                            title: 'Something went wrong!'
                        });  
                    }
                )
            },
            resetForm() {
                this.form.reset();
            },
            uploadImage(event) {
                this.form.image = '';
                this.imageErrors = '';
                var file = event.target.files[0];
                let reader = new FileReader();
                reader.onloadend = (event) => {
                    this.form.image = reader.result;
                    this.image = reader.result;
                }
                reader.readAsDataURL(file);
                const config = {
                    headers: { 'content-type': 'multipart/form-data' }
                }
                let formData = new FormData();
                formData.append('image', file);                 
                axios.post('/api/validateStoreImage', formData, config)
                .then((response) => {                                     
                    console.log(response.data);
                })
                .catch((error) => {
                    this.form.image = '';
                    this.image = '';
                    this.imageErrors = error.response.data.errors.image;                   
                })
            },
            deleteImage() {
                // if(this.editMode) {
                //     axios.get('/api/destroyBrandLogo/'+this.form.id).then(
                //         ({result}) => {
                //             console.log(result.message);
                //         }
                //     );
                // }
                this.image = '';
                this.form.image = '';
                this.imageErrors = '';
            },
            createMap() {
                mapboxgl.accessToken = this.token;
                this.addStoreMap = new mapboxgl.Map({
                    container: 'add-store-map',
                    center: [-80.21127912958411, 25.772579267751652],
                    zoom: 15,
                    style: this.style
                });
                this.canvas = this.addStoreMap.getCanvasContainer();   
                this.createControlls();                    
            },
            onMove(e) {
                var coords = e.lngLat;              
                // Set a UI indicator for dragging.
                this.canvas.style.cursor = 'grabbing';        
                // Update the Point feature in `geojson` coordinates
                // and call setData to the source layer `point` on it.
                this.geojson.features[0].geometry.coordinates = [coords.lng, coords.lat];
                this.addStoreMap.getSource('point').setData(this.geojson);
            },
            onUp(e) {
                var coords = e.lngLat;              
                // Print the coordinates of where the point had
                // finished being dragged to on the addStoreMap.
                this.canvas.style.cursor = '';            
                // Unbind mouse/touch events
                this.addStoreMap.off('mousemove', onMove);
                this.addStoreMap.off('touchmove', onMove);
            },
            onClick(e) {                 
                this.createControlls();  
                if(this.marker !== null) {
                    this.marker.remove(); // remove
                }           
                let lat = e.lngLat.lat;
                let lng = e.lngLat.lng;
                this.marker = new mapboxgl.Marker({
                    color: 'skyblue'
                })
                .setLngLat([lng, lat])
                .addTo(this.addStoreMap);
                this.getAddressInfo(`${lng},${lat}`);
            },
            createControlls() {
                if(this.geocoder) {
                    this.addStoreMap.removeControl(this.geocoder);
                    this.addStoreMap.removeControl(this.navigation);
                }
                this.geocoder = new MapboxGeocoder({
                    accessToken: this.token,
                    mapboxgl: mapboxgl,
                    marker: {
                        color: 'skyblue'
                    },
                    types: 'address',
                    getItemValue: e => {
                        this.getAddressInfo(`${e.geometry.coordinates[0]},${e.geometry.coordinates[1]}`);
                        if(this.marker !== null) {
                            this.marker.remove(); 
                        }
                    }
                });                  
                this.addStoreMap.addControl(this.geocoder);
                this.navigation = new mapboxgl.NavigationControl();
                this.addStoreMap.addControl(this.navigation);
            },
            getAddressInfo(coordinates) {
                return axios({
                    url: `https://api.mapbox.com/geocoding/v5/mapbox.places/${coordinates}.json?access_token=${this.token}&types=address,place`,
                    method: 'get',
                    headers: {
                        "Access-Control-Allow-Origin": "*"
                    }
                })
                .then((res) => {
                    this.form.address = res.data.features[0].place_name;
                    this.form.latitude = res.data.query[1];
                    this.form.longitude = res.data.query[0];
                    this.form.city = res.data.features[1].text;
                })
                .catch((error) => {
                    console.log(error);
                })
            }
        },
        created() {

        },   
        mounted() {
            this.createMap();       
            this.addStoreMap.on('load', function() {
                //console.log('Map loaded');
            });    
            this.addStoreMap.on('click', this.onClick);
        }
    }
</script>
