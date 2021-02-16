CLASS zcl_geojson_point DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_geojson .

  PUBLIC SECTION.
    INTERFACES zif_geojson_feature.

    METHODS constructor
      IMPORTING i_latitude  TYPE zcl_geojson=>ty_coordinate_value OPTIONAL
                i_longitude TYPE zcl_geojson=>ty_coordinate_value OPTIONAL.

    METHODS set_coordinate
      IMPORTING i_latitude  TYPE zcl_geojson=>ty_coordinate_value
                i_longitude TYPE zcl_geojson=>ty_coordinate_value.

    METHODS set_geometry_from_json
      IMPORTING i_json TYPE string.

    METHODS set_properties
      IMPORTING i_popup_content TYPE string OPTIONAL
                i_radius        TYPE i DEFAULT 8
                i_fill_color    TYPE string DEFAULT '#ff7800'
                i_color         TYPE string DEFAULT '#000000'
                i_weight        TYPE i DEFAULT 1
                i_opacity       TYPE zif_geojson_feature=>ty_opacity DEFAULT 1
                i_fill_opacity  TYPE zif_geojson_feature=>ty_opacity DEFAULT '0.8'.

    METHODS set_custom_properties
      IMPORTING i_properties TYPE REF TO data.

  PRIVATE SECTION.

    DATA: BEGIN OF _leaflet_properties,        "properties used by LeafletJS
            popup__content TYPE string,
            radius         TYPE i,             "these properties are only relevant, if you use circle markers
            fill__color    TYPE string,
            color          TYPE string,
            weight         TYPE i,
            opacity        TYPE zif_geojson_feature=>ty_opacity,
            fill__opacity  TYPE zif_geojson_feature=>ty_opacity,
          END OF _leaflet_properties.

    DATA: BEGIN OF _geometry,
            type        TYPE string,
            coordinates TYPE STANDARD TABLE OF zcl_geojson=>ty_coordinate_value,
          END OF _geometry.

    DATA: BEGIN OF _point,
            type       TYPE string,
            properties TYPE REF TO data,
            geometry   LIKE _geometry,
          END OF _point.

ENDCLASS.



CLASS zcl_geojson_point IMPLEMENTATION.


  METHOD constructor.
    _point-type = 'Feature'.
    _point-properties = REF #( _leaflet_properties ).
    _point-geometry-type = 'Point'.

    IF i_latitude IS SUPPLIED AND i_longitude IS SUPPLIED.
      set_coordinate(
        EXPORTING
          i_latitude = i_latitude
          i_longitude = i_longitude
      ).
    ENDIF.

    _leaflet_properties-radius = 8.
    _leaflet_properties-fill__color = '#ff7800'.
    _leaflet_properties-color = '#000000'.
    _leaflet_properties-weight = 1.
    _leaflet_properties-opacity = 1.
    _leaflet_properties-fill__opacity = '0.8'.

  ENDMETHOD.

  METHOD set_coordinate.
    _point-geometry-coordinates = VALUE #(
      ( i_longitude )
      ( i_latitude )
    ).
  ENDMETHOD.

  METHOD zif_geojson_feature~get_feature.
    r_result = REF #( _point ).
  ENDMETHOD.

  METHOD set_properties.

    IF i_popup_content IS SUPPLIED.
      _leaflet_properties-popup__content = i_popup_content.
    ENDIF.

    _leaflet_properties-radius = i_radius.
    _leaflet_properties-fill__color = i_fill_color.
    _leaflet_properties-color = i_color.
    _leaflet_properties-weight = i_weight.
    _leaflet_properties-opacity = i_opacity.
    _leaflet_properties-fill__opacity = i_fill_opacity.

  ENDMETHOD.

  METHOD set_custom_properties.
    _point-properties = i_properties.
  ENDMETHOD.

  METHOD set_geometry_from_json.

    /ui2/cl_json=>deserialize(
      EXPORTING
        json             = i_json
      CHANGING
        data             = _point-geometry
    ).

  ENDMETHOD.

ENDCLASS.
