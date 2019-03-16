CLASS zcl_geojson_point DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_geojson_feature .

  PUBLIC SECTION.
    TYPES: ty_coordinate_value TYPE p LENGTH 16 DECIMALS 13.

    METHODS constructor
      IMPORTING i_x TYPE ty_coordinate_value OPTIONAL
                i_y TYPE ty_coordinate_value OPTIONAL.
    METHODS set_point
      IMPORTING i_x TYPE ty_coordinate_value
                i_y TYPE ty_coordinate_value.
    METHODS get_geometry
      RETURNING VALUE(r_result) TYPE REF TO data.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: BEGIN OF _point,
            type        TYPE string,
            coordinates TYPE STANDARD TABLE OF ty_coordinate_value,
          END OF _point.

ENDCLASS.



CLASS zcl_geojson_point IMPLEMENTATION.


  METHOD constructor.
    _point-type = 'Point'.

    IF i_x IS SUPPLIED AND i_y IS SUPPLIED.
      set_point(
        EXPORTING
          i_x = i_x
          i_y = i_y
      ).
    ENDIF.

  ENDMETHOD.


  METHOD get_geometry.
    r_result = REF #( _point ).
  ENDMETHOD.


  METHOD set_point.
    _point-coordinates = VALUE #(
      ( i_x )
      ( i_y )
    ).
  ENDMETHOD.
ENDCLASS.
