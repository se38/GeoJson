CLASS zcl_geojson DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.
    METHODS get_feature_obj
      RETURNING VALUE(r_result) TYPE REF TO zcl_geojson_feature.
    METHODS add_feature
      IMPORTING i_feature TYPE REF TO data.
    METHODS get_json
      RETURNING VALUE(r_result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: BEGIN OF _featurecollection,
            type     TYPE string,
            features TYPE STANDARD TABLE OF REF TO data,
          END OF _featurecollection.

ENDCLASS.



CLASS zcl_geojson IMPLEMENTATION.
  METHOD add_feature.
    INSERT i_feature INTO TABLE _featurecollection-features.
  ENDMETHOD.

  METHOD constructor.
    _featurecollection-type = 'FeatureCollection'.
  ENDMETHOD.

  METHOD get_json.
    r_result = zcl_json_document=>create_with_data(
      data = _featurecollection
      replace_underscore = abap_true
      )->get_json( ).
  ENDMETHOD.

  METHOD get_feature_obj.
    r_result = NEW zcl_geojson_feature( ).
  ENDMETHOD.

ENDCLASS.
