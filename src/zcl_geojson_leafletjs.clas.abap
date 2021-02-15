CLASS zcl_geojson_leafletjs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "! Create LeafletJS HTML with GeoJSON source
    "! @parameter i_json | GeoJSON Source
    "! @parameter i_additional_layer | use an additional layer
    "! @parameter i_access_token | own access token
    METHODS get_html
      IMPORTING i_json               TYPE string
                i_additional_layer   TYPE string OPTIONAL
                i_access_token       TYPE string DEFAULT 'pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw'   "taken from the examples
                i_width_x_in_px      TYPE i DEFAULT 800
                i_width_y_in_px      TYPE i DEFAULT 500
                i_use_circle_markers TYPE abap_bool OPTIONAL
      RETURNING VALUE(r_result)      TYPE string.
    "! returns the HTML head part
    "! @parameter r_result | HTML head
    METHODS get_html_head
      RETURNING VALUE(r_result) TYPE string.
    "! returns the HTML body part
    "! @parameter i_json | GeoJSON Source
    "! @parameter i_additional_layer | use an additional layer
    "! @parameter i_access_token | own access token
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
` <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"` &&
`   integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="` &&
`   crossorigin=""/>` &&
` <!-- Make sure you put this AFTER Leaflet's CSS -->` &&
` <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"` &&
`   integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="` &&
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
`L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {` &&
`      attribution: '© <a href="https://www.mapbox.com/about/maps/">Mapbox</a> © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> <strong><a href="https://www.mapbox.com/map-feedback/" target="_blank">Improve this map</a></strong>` &&
`      | ABAP <a href="https://github.com/se38/GeoJson">GeoJSON</a> &copy; se38',` &&
`      tileSize: 512,` &&
`      maxZoom: 18,` &&
`      zoomOffset: -1,` &&
`      id: 'mapbox/streets-v11',` &&
|      accessToken: '{ i_access_token }'| &&
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
  `        radius: feature.properties.radius, ` &&
  `        fillColor: feature.properties.fillColor, ` &&
  `        color: feature.properties.color, ` &&
  `        weight: feature.properties.weight, ` &&
  `        opacity: feature.properties.opacity, ` &&
  `        fillOpacity: feature.properties.fillOpacity ` &&
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
