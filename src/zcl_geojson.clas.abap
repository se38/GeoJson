CLASS zcl_geojson DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_coordinate_value TYPE p LENGTH 16 DECIMALS 13.

    METHODS constructor.

    METHODS get_json
      RETURNING VALUE(r_result) TYPE string.

    METHODS get_new_point
      IMPORTING i_latitude      TYPE ty_coordinate_value OPTIONAL
                i_longitude     TYPE ty_coordinate_value OPTIONAL
      RETURNING VALUE(r_result) TYPE REF TO zcl_geojson_point.

    METHODS get_new_linestring
      RETURNING VALUE(r_result) TYPE REF TO zcl_geojson_linestring.

    METHODS get_new_polygon
      RETURNING VALUE(r_result) TYPE REF TO zcl_geojson_polygon.

    METHODS add_feature
      IMPORTING i_feature TYPE REF TO zif_geojson_feature.

  PRIVATE SECTION.
    DATA: BEGIN OF _featurecollection,
            type     TYPE string,
            features TYPE STANDARD TABLE OF REF TO data,
          END OF _featurecollection.

ENDCLASS.



CLASS zcl_geojson IMPLEMENTATION.


  METHOD add_feature.

    CHECK i_feature IS BOUND.
    INSERT i_feature->get_feature( ) INTO TABLE _featurecollection-features.

  ENDMETHOD.


  METHOD constructor.
    _featurecollection-type = 'FeatureCollection'.
  ENDMETHOD.


  METHOD get_json.
    r_result = zcl_json_document=>create_with_data(
      data = _featurecollection
      replace_underscore = abap_true
      replace_double_underscore = abap_true
      )->get_json( ).
  ENDMETHOD.


  METHOD get_new_point.

    r_result = NEW zcl_geojson_point(
        i_latitude  = i_latitude
        i_longitude = i_longitude
    ).

  ENDMETHOD.

  METHOD get_new_linestring.
    r_result = NEW zcl_geojson_linestring( ).
  ENDMETHOD.

  METHOD get_new_polygon.
    r_result = NEW zcl_geojson_polygon( ).
  ENDMETHOD.

ENDCLASS.
