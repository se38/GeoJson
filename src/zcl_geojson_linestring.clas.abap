CLASS zcl_geojson_linestring DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_geojson_feature .


  PUBLIC SECTION.
    TYPES: ty_coordinate_value TYPE p LENGTH 16 DECIMALS 13.

    METHODS constructor.
    METHODS add_coordinate
      IMPORTING i_x TYPE ty_coordinate_value
                i_y TYPE ty_coordinate_value.
    METHODS get_geometry
      RETURNING VALUE(r_result) TYPE REF TO data.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: _coordinate_pair TYPE STANDARD TABLE OF ty_coordinate_value.

    DATA: BEGIN OF _linestring,
            type        TYPE string,
            coordinates LIKE STANDARD TABLE OF _coordinate_pair,
          END OF _linestring.

ENDCLASS.



CLASS zcl_geojson_linestring IMPLEMENTATION.
  METHOD constructor.
    _linestring-type = 'LineString'.
  ENDMETHOD.

  METHOD add_coordinate.
    _coordinate_pair = VALUE #(
      ( i_x )
      ( i_y )
    ).
    INSERT _coordinate_pair INTO TABLE _linestring-coordinates.
  ENDMETHOD.

  METHOD get_geometry.
    r_result = REF #( _linestring ).
  ENDMETHOD.

ENDCLASS.
