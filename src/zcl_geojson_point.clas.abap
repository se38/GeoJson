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
      IMPORTING i_popup_content TYPE string OPTIONAL
                i_fill_color    TYPE string DEFAULT '#ff7800'.

    METHODS set_custom_properties
      IMPORTING i_properties TYPE REF TO data.

  PRIVATE SECTION.

    DATA: BEGIN OF _leaflet_properties,        "properties used by LeafletJS
            popup__content TYPE string,
            fill__color    TYPE string,        "only relevant, if you use circle markers
          END OF _leaflet_properties.

    DATA: BEGIN OF _geometry,
            type        TYPE string,
            coordinates TYPE STANDARD TABLE OF zcl_geojson=>ty_coordinate_value,
          END OF _geometry.

    DATA: BEGIN OF _point,
            type       TYPE string,
            properties TYPE REF TO data,
            geometry   LIKE _geometry,
          END OF _point.

ENDCLASS.



CLASS zcl_geojson_point IMPLEMENTATION.


  METHOD constructor.
    _point-type = 'Feature'.
    _point-properties = REF #( _leaflet_properties ).
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
      ( i_longitude )
      ( i_latitude )
    ).
  ENDMETHOD.

  METHOD zif_geojson_feature~get_feature.
    r_result = REF #( _point ).
  ENDMETHOD.

  METHOD set_properties.

    IF i_popup_content IS SUPPLIED.
      _leaflet_properties-popup__content = i_popup_content.
    ENDIF.

    IF i_fill_color IS NOT INITIAL.
      _leaflet_properties-fill__color = i_fill_color.
    ENDIF.

  ENDMETHOD.

  METHOD set_custom_properties.
    _point-properties = i_properties.
  ENDMETHOD.

ENDCLASS.
