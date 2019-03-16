CLASS zcl_geojson_feature DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_geojson.

  PUBLIC SECTION.
    METHODS constructor.
    METHODS set_properties
      IMPORTING i_properties TYPE REF TO data.
    METHODS set_geometry
      IMPORTING i_geometry TYPE REF TO data.
    METHODS get_feature
      RETURNING VALUE(r_result) TYPE REF TO data.
    METHODS get_point_obj
      IMPORTING i_x             TYPE zcl_geojson_point=>ty_coordinate_value OPTIONAL
                i_y             TYPE zcl_geojson_point=>ty_coordinate_value OPTIONAL
      RETURNING VALUE(r_result) TYPE REF TO zcl_geojson_point.
    METHODS get_linestring_obj
      RETURNING VALUE(r_result) TYPE REF TO zcl_geojson_linestring.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: BEGIN OF _properties,
            marker_color  TYPE string,
            marker_size   TYPE string,
            marker_symbol TYPE string,
          END OF _properties.

    DATA: BEGIN OF _feature,
            type       TYPE string,
            properties TYPE REF TO data,
            geometry   TYPE REF TO data,
          END OF _feature.

ENDCLASS.



CLASS zcl_geojson_feature IMPLEMENTATION.
  METHOD constructor.
    _feature-type = 'Feature'.

    _properties-marker_color = '#7e7e7e'.
    _properties-marker_size = 'medium'.
    _properties-marker_symbol = ''.

    set_properties( REF #( _properties ) ).
  ENDMETHOD.

  METHOD set_properties.
    _feature-properties = i_properties.
  ENDMETHOD.

  METHOD set_geometry.
    _feature-geometry = i_geometry.
  ENDMETHOD.

  METHOD get_feature.
    r_result = REF #( _feature ).
  ENDMETHOD.

  METHOD get_point_obj.
    r_result = NEW zcl_geojson_point(
      i_x = i_x
      i_y = i_y ).
  ENDMETHOD.

  METHOD get_linestring_obj.
    r_result = new zcl_geojson_linestring( ).
  ENDMETHOD.

ENDCLASS.
