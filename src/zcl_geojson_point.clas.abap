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

    METHODS set_properties
      IMPORTING i_marker_color  TYPE string OPTIONAL
                i_marker_size   TYPE string OPTIONAL
                i_marker_symbol TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES: BEGIN OF ty_properties,
             marker_color  TYPE string,
             marker_size   TYPE string,
             marker_symbol TYPE string,
           END OF ty_properties.

    DATA: BEGIN OF _geometry,
            type        TYPE string,
            coordinates TYPE STANDARD TABLE OF zcl_geojson=>ty_coordinate_value,
          END OF _geometry.

    DATA: BEGIN OF _point,
            type       TYPE string,
            properties TYPE ty_properties,
            geometry   LIKE _geometry,
          END OF _point.

ENDCLASS.



CLASS zcl_geojson_point IMPLEMENTATION.


  METHOD constructor.
    _point-type = 'Feature'.

    _point-properties-marker_color = '#7e7e7e'.
    _point-properties-marker_size = 'medium'.
    _point-properties-marker_symbol = ''.

    _point-geometry-type = 'Point'.

    IF i_latitude IS SUPPLIED AND i_longitude IS SUPPLIED.
      set_coordinate(
        EXPORTING
          i_latitude = i_latitude
          i_longitude = i_longitude
      ).
    ENDIF.

  ENDMETHOD.

  METHOD set_coordinate.
    _point-geometry-coordinates = VALUE #(
      ( i_latitude )
      ( i_longitude )
    ).
  ENDMETHOD.

  METHOD zif_geojson_feature~get_feature.
    r_result = REF #( _point ).
  ENDMETHOD.

  METHOD set_properties.

    IF i_marker_color IS SUPPLIED.
      _point-properties-marker_color = i_marker_color.
    ENDIF.

    IF i_marker_size IS SUPPLIED.
      _point-properties-marker_size = i_marker_size.
    ENDIF.

    IF i_marker_symbol IS SUPPLIED.
      _point-properties-marker_symbol = i_marker_symbol.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
