CLASS zcl_geojson_linestring DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_geojson .


  PUBLIC SECTION.
    INTERFACES zif_geojson_feature.

    TYPES: ty_opacity TYPE p LENGTH 2 DECIMALS 1.

    METHODS constructor.

    METHODS add_coordinate
      IMPORTING i_latitude  TYPE zcl_geojson=>ty_coordinate_value
                i_longitude TYPE zcl_geojson=>ty_coordinate_value.

    METHODS set_properties
      IMPORTING i_weight        TYPE i OPTIONAL              "properties for LeafletJS
                i_color         TYPE string OPTIONAL
                i_opacity       TYPE ty_opacity OPTIONAL
                i_popup_content TYPE string OPTIONAL.

*      IMPORTING i_stroke         TYPE string OPTIONAL      "properties used by geojson.io
*                i_stroke_width   TYPE i OPTIONAL
*                i_stroke_opacity TYPE ty_opacity OPTIONAL.

    METHODS set_custom_properties
      IMPORTING i_properties TYPE REF TO data.

  PRIVATE SECTION.

    TYPES: BEGIN OF ty_leaflet_style,
             weight        TYPE i,
             color         TYPE string,
             opacity       TYPE ty_opacity,
             fill__color   TYPE string,
             fill__opacity TYPE ty_opacity,
           END OF ty_leaflet_style.

    DATA: BEGIN OF _leaflet_properties,        "properties used by LeafletJS
            popup__content TYPE string,
            style          TYPE ty_leaflet_style,
          END OF _leaflet_properties.

*    DATA: BEGIN OF _geojson_io_properties,     "properties used by geojson.io
*            stroke         TYPE string,
*            stroke_width   TYPE p LENGTH 4 DECIMALS 1,
*            stroke_opacity TYPE p LENGTH 2 DECIMALS 1,
*          END OF _geojson_io_properties.

    DATA: _coordinate_pair TYPE STANDARD TABLE OF zcl_geojson=>ty_coordinate_value.

    DATA: BEGIN OF _geometry,
            type        TYPE string,
            coordinates LIKE STANDARD TABLE OF _coordinate_pair,
          END OF _geometry.

    DATA: BEGIN OF _linestring,
            type       TYPE string,
            properties TYPE REF TO data,
            geometry   LIKE _geometry,
          END OF _linestring.

ENDCLASS.



CLASS zcl_geojson_linestring IMPLEMENTATION.
  METHOD constructor.

    _linestring-type = 'Feature'.

*    _geojson_io_properties-stroke = '#555555'.
*    _geojson_io_properties-stroke_width = 2.
*    _geojson_io_properties-stroke_opacity = 1.

*    _polygon-properties = REF #( _geojson_io_properties ).

    _leaflet_properties-style-weight = 2.
    _leaflet_properties-style-color = '#555555'.
    _leaflet_properties-style-opacity = 1.

    _linestring-properties = REF #( _leaflet_properties ).

    _linestring-geometry-type = 'LineString'.
  ENDMETHOD.

  METHOD add_coordinate.
    _coordinate_pair = VALUE #(
      ( i_longitude )
      ( i_latitude )
    ).
    INSERT _coordinate_pair INTO TABLE _linestring-geometry-coordinates.
  ENDMETHOD.

  METHOD zif_geojson_feature~get_feature.
    r_result = REF #( _linestring ).
  ENDMETHOD.

  METHOD set_properties.

*--- properties for LeafletJS ---*
    IF i_weight IS SUPPLIED.
      _leaflet_properties-style-weight = i_weight.
    ENDIF.

    IF i_color IS SUPPLIED.
      _leaflet_properties-style-color = i_color.
    ENDIF.

    IF i_opacity IS SUPPLIED.
      _leaflet_properties-style-opacity = i_opacity.
    ENDIF.

    IF i_popup_content IS SUPPLIED.
      _leaflet_properties-popup__content = i_popup_content.
    ENDIF.

*    IF i_stroke IS SUPPLIED.
*      _geojson_io_properties-stroke = i_stroke.
*    ENDIF.
*
*    IF i_stroke_width IS SUPPLIED.
*      _geojson_io_properties-stroke_width = i_stroke_width.
*    ENDIF.
*
*    IF i_stroke_opacity IS SUPPLIED.
*      _geojson_io_properties-stroke_opacity = i_stroke_opacity.
*    ENDIF.

  ENDMETHOD.

  METHOD set_custom_properties.
    _linestring-properties = i_properties.
  ENDMETHOD.

ENDCLASS.
