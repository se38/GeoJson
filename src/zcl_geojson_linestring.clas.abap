CLASS zcl_geojson_linestring DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_geojson .


  PUBLIC SECTION.
    INTERFACES zif_geojson_feature.

    TYPES: ty_stroke_width   TYPE p LENGTH 4 DECIMALS 1,
           ty_stroke_opacity TYPE p LENGTH 2 DECIMALS 1.

    METHODS constructor.
    METHODS add_coordinate
      IMPORTING i_x TYPE zcl_geojson=>ty_coordinate_value
                i_y TYPE zcl_geojson=>ty_coordinate_value.
    METHODS set_properties
      IMPORTING i_stroke         TYPE string OPTIONAL
                i_stroke_width   TYPE ty_stroke_width OPTIONAL
                i_stroke_opacity TYPE ty_stroke_opacity OPTIONAL.


  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES: BEGIN OF ty_properties,
             stroke         TYPE string,
             stroke_width   TYPE p LENGTH 4 DECIMALS 1,
             stroke_opacity TYPE p LENGTH 2 DECIMALS 1,
           END OF ty_properties.

    DATA: _coordinate_pair TYPE STANDARD TABLE OF zcl_geojson=>ty_coordinate_value.

    DATA: BEGIN OF _geometry,
            type        TYPE string,
            coordinates LIKE STANDARD TABLE OF _coordinate_pair,
          END OF _geometry.

    DATA: BEGIN OF _linestring,
            type       TYPE string,
            properties TYPE ty_properties,
            geometry   LIKE _geometry,
          END OF _linestring.

ENDCLASS.



CLASS zcl_geojson_linestring IMPLEMENTATION.
  METHOD constructor.

    _linestring-type = 'Feature'.

    _linestring-properties-stroke = '#555555'.
    _linestring-properties-stroke_width = 2.
    _linestring-properties-stroke_opacity = 1.

    _linestring-geometry-type = 'LineString'.
  ENDMETHOD.

  METHOD add_coordinate.
    _coordinate_pair = VALUE #(
      ( i_x )
      ( i_y )
    ).
    INSERT _coordinate_pair INTO TABLE _linestring-geometry-coordinates.
  ENDMETHOD.

  METHOD zif_geojson_feature~get_feature.
    r_result = REF #( _linestring ).
  ENDMETHOD.

  METHOD set_properties.

    IF i_stroke IS SUPPLIED.
      _linestring-properties-stroke = i_stroke.
    ENDIF.

    IF i_stroke_width IS SUPPLIED.
      _linestring-properties-stroke_width = i_stroke_width.
    ENDIF.

    IF i_stroke_opacity IS SUPPLIED.
      _linestring-properties-stroke_opacity = i_stroke_opacity.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
