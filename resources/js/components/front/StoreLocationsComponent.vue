<template>
  <div class="" style="position:relative; top:100px;">
    <div class='map-sidebar list-bckg pad2'>
      <div class='list-heading'>
        <h1 class="store-list-h1">Our Stores</h1>
      </div>
      <div id='listings' class='listings'>
        <div v-for="(store, index) in stores.features" :key="index" :id="'listing-'+store.properties.id" class="store-item">
          <a @click="flyToStore(store)" class="store-list-a store-title" :id="'link-'+store.properties.id">{{ store.properties.title }}</a>
          <div>
            {{ store.properties.address }}
          </div>
        </div>
      </div>
    </div>
    <div id='map' class='store-locations-map pad2'>Map</div>
  </div>
</template>

<script>

export default {
    data() {
        return {
            token: 'pk.eyJ1IjoiZHVraTg3IiwiYSI6ImNrNHp5NmNqYjBjOG4za21peXdkbHFldWwifQ.pmTnS8cOoO9bFXWnWu1-5A',
            map: '',
            stores: {
              type: "FeatureCollection",
              features: []
            },
            ready: false
        }
    },
    methods: {
      createMap() {
          mapboxgl.accessToken = this.token;
          this.map = new mapboxgl.Map({
            container: 'map',
            style: 'mapbox://styles/mapbox/light-v10',
            center: [-80.21127912958411, 25.772579267751652],
            zoom: 15
        });
      },
      loadStores() {
        return axios.get('/api/store')
        .then(({data}) => {
          let stores = data.stores;
          stores.forEach(store => {
            let storeData = {
              "type": "Feature",
              "geometry": {
                "type": "Point",
                "coordinates": [
                  store.longitude,
                  store.latitude
                ]
              },
              "properties": {
                "id": store.id,
                "title": store.title,
                "phone": store.phone,
                "address": store.address,
                "city": store.city,
                "image": store.image
              }
            };
            this.stores.features.push(storeData);
          });          
        })
        .catch((error) => {
          console.log(error);
        });
      },
      addStoresToMap() {
        this.map.addLayer({
          "id": "locations",
          "type": "symbol",
          /* Add a GeoJSON source containing place coordinates and information. */
          "source": {
            "type": "geojson",
            "data": this.stores
          },
          "layout": {
            "icon-image": "commercial-15",
            "icon-allow-overlap": true,
          }
        });
        this.ready = true;
      },
      flyToStore(currentFeature) {
        this.map.flyTo({
          center: currentFeature.geometry.coordinates,
          zoom: 15
        });
        this.createPopUp(currentFeature);
      },
      createPopUp(currentFeature) {
        var popUps = document.getElementsByClassName('mapboxgl-popup');
        /** Check if there is already a popup on the map and if so, remove it */
        if (popUps[0]) popUps[0].remove();
        var popup = new mapboxgl.Popup({ closeOnClick: false })
          .setLngLat(currentFeature.geometry.coordinates)
          .setHTML(
            '<img class="mapbox-popup-img" src="images/stores/'+currentFeature.properties.image+'">'+
            '<h5>'+ currentFeature.properties.title +'</h5>' +
            '<h6>' + currentFeature.properties.address + '</h6>' +
            '<h6>+' + currentFeature.properties.phone + '</h6>'
            )
          .addTo(this.map);
      }
    },
    mounted() {
      this.createMap();
      this.loadStores();    
      this.map.on('load', this.addStoresToMap, this.buildLocationList);  
    }
}
</script>
