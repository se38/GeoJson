INTERFACE zif_geojson_feature
  PUBLIC .

  METHODS get_feature
    RETURNING VALUE(r_result) TYPE REF TO data.

ENDINTERFACE.
