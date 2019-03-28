CLASS zcl_geojson_leafletjs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_html
      IMPORTING i_json          TYPE string
      RETURNING VALUE(r_result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_geojson_leafletjs IMPLEMENTATION.
  METHOD get_html.

    r_result =
`<html>` &&
`<head>` &&
` <link rel="stylesheet" href="https://unpkg.com/leaflet@1.4.0/dist/leaflet.css"` &&
`   integrity="sha512-puBpdR0798OZvTTbP4A8Ix/l+A4dHDD0DGqYW6RQ+9jxkRFclaxxQb/SJAWZfWAkuyeQUytO7+7N4QKrDh+drA=="` &&
`   crossorigin=""/>` &&
`` &&
` <!-- Make sure you put this AFTER Leaflet's CSS -->` &&
` <script src="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js"` &&
`   integrity="sha512-QVftwZFqvtRNi0ZyCtsznlKSWOStnDORoefr1enyq5mVL4tmKB3S/EnC3rRJcxCPavG10IcrVGSmPh6Qw5lwrg=="` &&
`   crossorigin=""></script>   ` &&
`</head>` &&
`` &&
`<body>` &&
`<div id="mapid" style="width: 800px; height: 500px;"></div>` &&
`` &&
`<script>` &&
`` &&
`var mymap = L.map('mapid');` &&
`` &&
`L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {` &&
`    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +` &&
`      '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +` &&
`      '| ABAP <a href="https://github.com/se38/GeoJson">GeoJSON</a> &copy; se38',` &&
`    maxZoom: 20,` &&
`    id: 'mapbox.streets',` &&
`    accessToken: 'pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw'` &&
`}).addTo(mymap);` &&
`` &&
`var geojsonFeature = ###json###;` &&
`` &&
`var geojsonLayer = L.geoJSON(geojsonFeature);` &&
`geojsonLayer.addTo(mymap);` &&
`mymap.fitBounds(geojsonLayer.getBounds())` &&
`// L.geoJSON(geojsonFeature).addTo(mymap);` &&
`` &&
`</script>` &&
`` &&
`</body>   ` &&
`</html>`.

    REPLACE '###json###' IN r_result WITH i_json.
  ENDMETHOD.

ENDCLASS.
