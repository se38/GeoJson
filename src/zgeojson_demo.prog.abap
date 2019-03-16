*&---------------------------------------------------------------------*
*& Report zgeojson_demo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zgeojson_demo.

CLASS app DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS main.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

NEW app( )->main( ).

CLASS app IMPLEMENTATION.

  METHOD main.

    DATA(geojson) = NEW zcl_geojson( ).
    DATA(feature) = geojson->get_feature_obj( ).

    DATA(point) = feature->get_point_obj(
      i_x = CONV #( '6.741185188293457' )
      i_y = CONV #( '51.134054817288565' )
    ).

    feature->set_geometry( point->get_geometry( ) ).
    geojson->add_feature( feature->get_feature( ) ).

    feature = geojson->get_feature_obj( ).
    DATA(linestring) = feature->get_linestring_obj( ).
    linestring->add_coordinate(
      EXPORTING
        i_x = CONV #( '6.741539239883423' )
        i_y = CONV #( '51.134282033499524' )
    ).
    linestring->add_coordinate(
      EXPORTING
        i_x = CONV #( '6.741458773612976' )
        i_y = CONV #( '51.133851163290046' )
    ).
    feature->set_geometry( linestring->get_geometry( ) ).
    geojson->add_feature( feature->get_feature( ) ).

    cl_demo_output=>display_json( geojson->get_json( ) ).
  ENDMETHOD.

ENDCLASS.
