CLASS zcl_geojson_polygon DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_geojson .

  PUBLIC SECTION.
    INTERFACES zif_geojson_feature.

    METHODS constructor.

    METHODS add_coordinate
      IMPORTING i_latitude  TYPE zcl_geojson=>ty_coordinate_value
                i_longitude TYPE zcl_geojson=>ty_coordinate_value.

    METHODS set_properties
      IMPORTING i_weight        TYPE i OPTIONAL              "properties for LeafletJS
                i_color         TYPE string OPTIONAL
                i_opacity       TYPE zif_geojson_feature=>ty_opacity OPTIONAL
                i_fill_color    TYPE string OPTIONAL
                i_fill_opacity  TYPE zif_geojson_feature=>ty_opacity OPTIONAL
                i_popup_content TYPE string OPTIONAL.

    METHODS set_custom_properties
      IMPORTING i_properties TYPE REF TO data.

    METHODS finalize.

  PRIVATE SECTION.

    TYPES: BEGIN OF ty_leaflet_style,
             weight        TYPE i,
             color         TYPE string,
             opacity       TYPE zif_geojson_feature=>ty_opacity,
             fill__color   TYPE string,
             fill__opacity TYPE zif_geojson_feature=>ty_opacity,
           END OF ty_leaflet_style.

    DATA: BEGIN OF _leaflet_properties,        "properties used by LeafletJS
            popup__content TYPE string,
            style          TYPE ty_leaflet_style,
          END OF _leaflet_properties.

    DATA: _coordinate_pair TYPE STANDARD TABLE OF zcl_geojson=>ty_coordinate_value.
    DATA: _coordinate_pairs LIKE STANDARD TABLE OF _coordinate_pair.

    DATA: BEGIN OF _geometry,
            type        TYPE string,
            coordinates LIKE STANDARD TABLE OF _coordinate_pairs,
          END OF _geometry.

    DATA: BEGIN OF _polygon,
            type       TYPE string,
            properties TYPE REF TO data,
            geometry   LIKE _geometry,
          END OF _polygon.

ENDCLASS.



CLASS zcl_geojson_polygon IMPLEMENTATION.
  METHOD constructor.

    _polygon-type = 'Feature'.

    _leaflet_properties-style-weight = 2.
    _leaflet_properties-style-color = '#555555'.
    _leaflet_properties-style-opacity = 1.
    _leaflet_properties-style-fill__color = '#555555'.
    _leaflet_properties-style-fill__opacity = '0.5'.

    _polygon-properties = REF #( _leaflet_properties ).
    _polygon-geometry-type = 'Polygon'.

  ENDMETHOD.

  METHOD add_coordinate.

    _coordinate_pair = VALUE #(
      ( i_longitude )
      ( i_latitude )
    ).

    INSERT _coordinate_pair INTO TABLE _coordinate_pairs.

  ENDMETHOD.

  METHOD zif_geojson_feature~get_feature.
    r_result = REF #( _polygon ).
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

    IF i_fill_color IS SUPPLIED.
      _leaflet_properties-style-fill__color = i_fill_color.
    ENDIF.

    IF i_fill_opacity IS SUPPLIED.
      _leaflet_properties-style-fill__opacity = i_fill_opacity.
    ENDIF.

    IF i_popup_content IS SUPPLIED.
      _leaflet_properties-popup__content = i_popup_content.
    ENDIF.

  ENDMETHOD.

  METHOD finalize.
    INSERT _coordinate_pairs INTO TABLE _polygon-geometry-coordinates.
    CLEAR _coordinate_pairs.
  ENDMETHOD.

  METHOD set_custom_properties.
    _polygon-properties = i_properties.
  ENDMETHOD.

ENDCLASS.
