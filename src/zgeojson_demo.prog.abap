* See https://github.com/se38/GeoJson

********************************************************************************
* The MIT License (MIT)
*
* Copyright (c) 2019 Uwe Fetzer and the ABAP GeoJson Contributors
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

REPORT zgeojson_demo.

CLASS app DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS main.

ENDCLASS.

NEW app( )->main( ).

CLASS app IMPLEMENTATION.

  METHOD main.

    DATA(geojson) = NEW zcl_geojson( ).

    "*--- add a marker at WDF03 ---*
    DATA(point) = geojson->get_new_point(
      i_latitude = CONV #( '49.29278417339369' )
      i_longitude = CONV #( '8.64398717880249' )
    ).

    point->set_properties(
        i_popup_content = 'This is where the cool shit happens'
    ).

    geojson->add_feature( point ).

    "*--- add a red point (only if Circle markers are activated, see below) ---*
    point = geojson->get_new_point(
      i_latitude = CONV #( '49.292100' )
      i_longitude = CONV #( '8.643500' )
    ).

    point->set_properties(
        i_popup_content = 'red'
        i_fill_color = '#ff0000'
    ).

    geojson->add_feature( point ).

    "*--- add a green point (only if Circle markers are activated, see below) ---*
    point = geojson->get_new_point(
      i_latitude = CONV #( '49.292200' )
      i_longitude = CONV #( '8.643600' )
    ).

    point->set_properties(
        i_popup_content = 'green'
        i_fill_color = '#00ff00'
    ).

    geojson->add_feature( point ).

    "*--- mark WDF03 with an "X" (with two LineStrings) ---*
    DATA(linestring) = geojson->get_new_linestring( ).
    linestring->set_properties(
        i_weight = '5'
        i_color = '#ff0000'
        i_popup_content = 'Dig deep here to find the treasure'
    ).

    linestring->add_coordinate(
        i_latitude = CONV #( '49.2926197370113' )
        i_longitude = CONV #( '8.643386363983154' )
    ).

    linestring->add_coordinate(
        i_latitude = CONV #( '49.29260574240025' )
        i_longitude = CONV #( '8.643944263458252' )
    ).

    geojson->add_feature( linestring ).

    linestring = geojson->get_new_linestring( ).
    linestring->set_properties(
        i_weight = '5'
        i_color = '#ff0000'
    ).

    linestring->add_coordinate(
        i_latitude = CONV #( '49.29243080942674' )
        i_longitude = CONV #( '8.643686771392822' )
    ).

    linestring->add_coordinate(
        i_latitude = CONV #( '49.292742189688624' )
        i_longitude = CONV #( '8.643670678138733' )
    ).

    geojson->add_feature( linestring ).

    "*--- add an arrow pointing to WDF03 ---*
    DATA(polygon) = geojson->get_new_polygon( ).

    polygon->set_properties(
        i_weight = 5
        i_fill_color = '#0000ff'
        i_fill_opacity = '0.2'
        i_popup_content = 'This is ABAP GeoJSON #ABAPsNotDead'
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.29239932142559' )
        i_longitude = CONV #( '8.643407821655273' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.2923433427072' )
        i_longitude = CONV #( '8.642807006835938' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.29225937451043' )
        i_longitude = CONV #( '8.643085956573486' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.291888513263814' )
        i_longitude = CONV #( '8.642517328262329' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.29180454429229' )
        i_longitude = CONV #( '8.642646074295044' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.292175406170635' )
        i_longitude = CONV #( '8.643161058425903' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.292063448161734' )
        i_longitude = CONV #( '8.643268346786499' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.29239932142559' )
        i_longitude = CONV #( '8.643407821655273' )
    ).

    polygon->finalize( ).

    "*--- add a box arround WDF01 (same polygon = same properties) ---*
    polygon->add_coordinate(
        i_latitude = CONV #( '49.29453346265389' )
        i_longitude = CONV #( '8.64200234413147' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.293392933098836' )
        i_longitude = CONV #( '8.640178442001343' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.29279117067437' )
        i_longitude = CONV #( '8.641133308410645' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.293973696844695' )
        i_longitude = CONV #( '8.642892837524414' )
    ).

    polygon->add_coordinate(
        i_latitude = CONV #( '49.29453346265389' )
        i_longitude = CONV #( '8.64200234413147' )
    ).

    polygon->finalize( ).

    geojson->add_feature( polygon ).

*    cl_demo_output=>display_json( geojson->get_json( ) ).

    "*--- needs SAPGUI, start report with <f8>        ---*
    "*--- does not work with Eclipse console <f9>     ---*
    "*--- does not work in ABAP on SAP Cloud Platform ---*
*    DATA(encoded_json) = cl_http_utility=>escape_url( geojson->get_json( ) ).
*
*    cl_gui_frontend_services=>execute(
*      EXPORTING
*        document               = |http://geojson.io/#data=data:application/json,{ encoded_json }|     " Path+Name to Document
*      EXCEPTIONS
*        OTHERS                 = 0
*    ).

    "*--- needs SAPGUI, start report with <f8>        ---*
    "*--- does not work with Eclipse console <f9>     ---*
    "*--- does not work in ABAP on SAP Cloud Platform ---*
    "*--- needs Internet connection                   ---*
    cl_demo_output=>display_html(
        NEW zcl_geojson_leafletjs( )->get_html(
            i_json = geojson->get_json( )
            i_width_x_in_px = 900
            i_use_circle_markers = abap_true
        )
    ).

  ENDMETHOD.

ENDCLASS.
