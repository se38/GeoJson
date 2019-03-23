CLASS zcl_geojson_linestring DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_geojson .


  PUBLIC SECTION.
    INTERFACES zif_geojson_feature.

    TYPES: ty_width   TYPE p LENGTH 4 DECIMALS 1,
           ty_opacity TYPE p LENGTH 2 DECIMALS 1.

    METHODS constructor.

    METHODS add_coordinate
      IMPORTING i_latitude  TYPE zcl_geojson=>ty_coordinate_value
                i_longitude TYPE zcl_geojson=>ty_coordinate_value.

    METHODS set_properties
      IMPORTING i_stroke         TYPE string OPTIONAL
                i_stroke_width   TYPE ty_width OPTIONAL
                i_stroke_opacity TYPE ty_opacity OPTIONAL.

    METHODS set_custom_properties
      IMPORTING i_properties TYPE REF TO data.

  PRIVATE SECTION.

    DATA: BEGIN OF _geojson_io_properties,     "properties used by geojson.io
            stroke         TYPE string,
            stroke_width   TYPE p LENGTH 4 DECIMALS 1,
            stroke_opacity TYPE p LENGTH 2 DECIMALS 1,
          END OF _geojson_io_properties.

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

    _geojson_io_properties-stroke = '#555555'.
    _geojson_io_properties-stroke_width = 2.
    _geojson_io_properties-stroke_opacity = 1.

    _linestring-properties = REF #( _geojson_io_properties ).

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

    IF i_stroke IS SUPPLIED.
      _geojson_io_properties-stroke = i_stroke.
    ENDIF.

    IF i_stroke_width IS SUPPLIED.
      _geojson_io_properties-stroke_width = i_stroke_width.
    ENDIF.

    IF i_stroke_opacity IS SUPPLIED.
      _geojson_io_properties-stroke_opacity = i_stroke_opacity.
    ENDIF.

  ENDMETHOD.

  METHOD set_custom_properties.
    _linestring-properties = i_properties.
  ENDMETHOD.

ENDCLASS.
