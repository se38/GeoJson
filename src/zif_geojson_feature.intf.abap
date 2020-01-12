INTERFACE zif_geojson_feature
  PUBLIC .

  TYPES: ty_opacity TYPE p LENGTH 2 DECIMALS 1.

  METHODS get_feature
    RETURNING VALUE(r_result) TYPE REF TO data.

ENDINTERFACE.
