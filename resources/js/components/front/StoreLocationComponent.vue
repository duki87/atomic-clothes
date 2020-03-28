<template>
  <MglMap
    container="map-test"
    :center.sync="center"
    :accessToken="accessToken"
    :mapStyle="mapStyle"
  >
    <MglMarker
      :coordinates.sync="markerCoordinates"
      color='green'
    />
    <MglGeojsonLayer
      type="fill"
      :sourceId="sourceId"
      :layerId="layerId"
      :source="geojson"
      @click="handleClick"
    />
  </MglMap>
</template>

<script>

export default {
    data() {
        return {
            accessToken: 'pk.eyJ1IjoiZHVraTg3IiwiYSI6ImNrNHp5NmNqYjBjOG4za21peXdkbHFldWwifQ.pmTnS8cOoO9bFXWnWu1-5A',
            mapStyle: 'mapbox://map_style',
            geojson: { /* … some geojson */},
            //layerId: 'firstLayer',
            //sourceId: 'firstSource',
            markerCoordinates='[50, 50]'
        }
    }
}
</script>