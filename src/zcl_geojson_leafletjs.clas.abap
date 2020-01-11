CLASS zcl_geojson_leafletjs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_html
      IMPORTING i_json               TYPE string
                i_additional_layer   TYPE string OPTIONAL
                i_access_token       TYPE string DEFAULT 'pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw'   "taken from the examples
                i_width_x_in_px      TYPE i DEFAULT 800
                i_width_y_in_px      TYPE i DEFAULT 500
                i_use_circle_markers TYPE abap_bool OPTIONAL
      RETURNING VALUE(r_result)      TYPE string.
    METHODS get_html_head
      RETURNING VALUE(r_result) TYPE string.
    METHODS get_html_body
      IMPORTING i_json               TYPE string
                i_additional_layer   TYPE string OPTIONAL
                i_access_token       TYPE string DEFAULT 'pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw'   "taken from the examples
                i_width_x_in_px      TYPE i OPTIONAL
                i_width_y_in_px      TYPE i OPTIONAL
                i_use_circle_markers TYPE abap_bool OPTIONAL
      RETURNING VALUE(r_result)      TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_geojson_leafletjs IMPLEMENTATION.
  METHOD get_html.

    r_result =
`<html>` &&
`<head>` &&
|{ get_html_head( ) }| &&
`</head>` &&
`` &&
`<body>` &&
|{ get_html_body( i_json = i_json
                  i_additional_layer = i_additional_layer
                  i_access_token = i_access_token
                  i_width_x_in_px = i_width_x_in_px
                  i_width_y_in_px = i_width_y_in_px
                  i_use_circle_markers = i_use_circle_markers
                ) }| &&
`</body>   ` &&
`</html>`.

  ENDMETHOD.

  METHOD get_html_head.

    r_result =
` <link rel="stylesheet" href="https://unpkg.com/leaflet@1.4.0/dist/leaflet.css"` &&
`   integrity="sha512-puBpdR0798OZvTTbP4A8Ix/l+A4dHDD0DGqYW6RQ+9jxkRFclaxxQb/SJAWZfWAkuyeQUytO7+7N4QKrDh+drA=="` &&
`   crossorigin=""/>` &&
` <!-- Make sure you put this AFTER Leaflet's CSS -->` &&
` <script src="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js"` &&
`   integrity="sha512-QVftwZFqvtRNi0ZyCtsznlKSWOStnDORoefr1enyq5mVL4tmKB3S/EnC3rRJcxCPavG10IcrVGSmPh6Qw5lwrg=="` &&
`   crossorigin=""></script>   `.

  ENDMETHOD.

  METHOD get_html_body.

    IF i_additional_layer IS NOT INITIAL.
      DATA(additional_layer) = |var layerGeojson = { i_additional_layer };| &&
                               |var additionalLayer = L.geoJSON(layerGeojson);| &&
                               |additionalLayer.addTo(mymap);| &&
                               |mymap.fitBounds(additionalLayer.getBounds());|.
    ENDIF.

    r_result =
|<div id="mapid" style="width: { i_width_x_in_px }px; height: { i_width_y_in_px }px;"></div>| &&
`<script>` &&
`var mymap = L.map('mapid');` &&
`L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {` &&
`    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +` &&
`      '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +` &&
`      '| ABAP <a href="https://github.com/se38/GeoJson">GeoJSON</a> &copy; se38',` &&
`    maxZoom: 20,` &&
`    id: 'mapbox.streets',` &&
|    accessToken: '{ i_access_token }'| &&
`}).addTo(mymap);` &&
|var geojsonFeature = { i_json };| &&
`var geojsonLayer = L.geoJSON(geojsonFeature, {` &&
`    style: function (feature) {` &&
`      return feature.properties && feature.properties.style;` &&
`    },` &&
`    onEachFeature: function (f, l) { ` &&
`      if (f.properties.popupContent) { l.bindPopup(f.properties.popupContent) }; ` &&
`    } `.

    IF i_use_circle_markers = abap_true.
      r_result = r_result &&
  `    , ` &&
  `    pointToLayer: function (feature, latlng) { ` &&
  `      return L.circleMarker(latlng, { ` &&
  `        radius: 8, ` &&
  `        fillColor: feature.properties.popupContent, ` &&
  `        color: "#000", ` &&
  `        weight: 1, ` &&
  `        opacity: 1, ` &&
  `        fillOpacity: 0.8 ` &&
  `      }); ` &&
  `    } `.
    ENDIF.

    r_result = r_result &&
  `  });` &&
  `geojsonLayer.addTo(mymap);` &&
  `mymap.fitBounds(geojsonLayer.getBounds());` &&
  |{ additional_layer }| &&
  `</script>`.

  ENDMETHOD.

ENDCLASS.
