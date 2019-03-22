* See https://github.com/se38/GeoJson

********************************************************************************
* The MIT License (MIT)
*
* Copyright (c) 2019 GeoJson Contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
********************************************************************************

*&---------------------------------------------------------------------*
*& Report zgeojson_demo
*&---------------------------------------------------------------------*
*& Copy/Paste the output into http://geojson.io
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

    "*--- add a marker at WDF03 ---*
    DATA(point) = geojson->get_new_point(
      i_latitude = CONV #( '8.64398717880249' )
      i_longitude = CONV #( '49.29278417339369' )
    ).

    point->set_properties(
      i_marker_color = '#FF0000'
      i_marker_symbol = 'circle'
    ).

    geojson->add_feature( point ).

    "*--- add a line near Dietmar-Hopp-Allee ---*
    DATA(linestring) = geojson->get_new_linestring( ).

    linestring->set_properties(
        i_stroke_width   = '10.4'
        i_stroke_opacity = '0.5'
    ).

    linestring->add_coordinate(
        i_latitude = CONV #( '8.643182516098022' )
        i_longitude = CONV #( '49.293959702618004' )
    ).

    linestring->add_coordinate(
        i_latitude = CONV #( '8.64122986793518' )
        i_longitude = CONV #( '49.29271420053207' )
    ).


    geojson->add_feature( linestring ).

    "*--- add an arrow pointing to WDF03 ---*
    DATA(polygon) = geojson->get_new_polygon( ).

    polygon->set_properties(
        i_fill = '#550000'
        i_fill_opacity = '0.3'
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.643407821655273' )
        i_longitude = CONV #( '49.29239932142559' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.642807006835938' )
        i_longitude = CONV #( '49.2923433427072' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.643085956573486' )
        i_longitude = CONV #( '49.29225937451043' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.642517328262329' )
        i_longitude = CONV #( '49.291888513263814' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.642646074295044' )
        i_longitude = CONV #( '49.29180454429229' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.643161058425903' )
        i_longitude = CONV #( '49.292175406170635' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.643268346786499' )
        i_longitude = CONV #( '49.292063448161734' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.643407821655273' )
        i_longitude = CONV #( '49.29239932142559' )
    ).

    polygon->finalize( ).

    "*--- add a box arround WDF01 (same polygon) ---*
    polygon->add_coordinate(
        i_latitude = CONV #( '8.64200234413147' )
        i_longitude = CONV #( '49.29453346265389' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.640178442001343' )
        i_longitude = CONV #( '49.293392933098836' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.641133308410645' )
        i_longitude = CONV #( '49.29279117067437' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.642892837524414' )
        i_longitude = CONV #( '49.293973696844695' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '8.64200234413147' )
        i_longitude = CONV #( '49.29453346265389' )
    ).

    polygon->finalize( ).

    geojson->add_feature( polygon ).

    cl_demo_output=>display_json( geojson->get_json( ) ).

  ENDMETHOD.

ENDCLASS.
