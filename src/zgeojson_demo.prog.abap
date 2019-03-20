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
    DATA(point) = geojson->get_new_point(
      i_latitude = CONV #( '6.741185188293457' )
      i_longitude = CONV #( '51.134054817288565' )
    ).

    point->set_properties(
      i_marker_color = '#FF0000'
      i_marker_symbol = 'circle'
    ).

    geojson->add_feature( point ).

    DATA(linestring) = geojson->get_new_linestring( ).

    linestring->add_coordinate(
        i_x = CONV #( '6.741539239883423' )
        i_y = CONV #( '51.134282033499524' )
    ).

    linestring->add_coordinate(
        i_x = CONV #( '6.741458773612976' )
        i_y = CONV #( '51.133851163290046' )
    ).

    linestring->set_properties(
        i_stroke_width   = '10.4'
        i_stroke_opacity = '0.5'
    ).

    geojson->add_feature( linestring ).

    cl_demo_output=>display_json( geojson->get_json( ) ).
  ENDMETHOD.

ENDCLASS.
