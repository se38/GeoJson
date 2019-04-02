* See https://github.com/se38/GeoJson

********************************************************************************
* The MIT License (MIT)
*
* Copyright (c) 2019 Uwe Fetzer and the 2019 GeoJson Contributors
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
*& Add additional layer to the map
*&---------------------------------------------------------------------*

REPORT zgeojson_demo_layer.

CLASS app DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS main.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_layer_from_mime_repository
      RETURNING VALUE(r_result) TYPE string.

ENDCLASS.

NEW app( )->main( ).

CLASS app IMPLEMENTATION.

  METHOD main.

    DATA(geojson) = NEW zcl_geojson( ).

    "*--- add a marker ---*
    DATA(point) = geojson->get_new_point(
      i_latitude = CONV #( '51.223577' )
      i_longitude = CONV #( '6.769356' )
    ).

    point->set_properties( 'One of the nices places of the world' ).
    geojson->add_feature( point ).

    cl_demo_output=>display_html(
        NEW zcl_geojson_leafletjs( )->get_html(
            i_json = geojson->get_json( )
            i_additional_layer = get_layer_from_mime_repository( )
            i_width_x_in_px = 900
        )
    ).

  ENDMETHOD.

  METHOD get_layer_from_mime_repository.

    DATA(mime_api) = cl_mime_repository_api=>get_api( ).

    mime_api->get(
      EXPORTING
        i_url = '/SAP/PUBLIC/GeoJSON/duesseldorf.geojson'
      IMPORTING
        e_content = DATA(layer) ).

    DATA(conv) = cl_abap_conv_in_ce=>create(
        input       = layer
        encoding    = 'UTF-8' ).

    conv->read(
      IMPORTING
        data = r_result ).

  ENDMETHOD.

ENDCLASS.
