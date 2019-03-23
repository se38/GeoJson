# GeoJSON
ABAP Classes to create GeoJSON strings according to [RFC 7946](https://tools.ietf.org/html/rfc7946)

## Installation
Import Source with [abapGit](https://github.com/larshp/abapGit)

## Required Packages
Needs [JSON Document Class](https://github.com/se38/zjson) with at least version 2.32
```
write:/ zcl_json_document=>get_version( ).
```
## Usage
This example will create a simple point object:
```
    DATA(geojson) = NEW zcl_geojson( ).
    DATA(point) = geojson->get_new_point(
      i_latitude = CONV #( '49.29278417339369' )
      i_longitude = CONV #( '8.64398717880249' )
    ).
    geojson->add_feature( point ).
    cl_demo_output=>display_json( geojson->get_json( ) ).
```
Result
```
{
 "type":"FeatureCollection",
 "features":
 [
  {
   "type":"Feature",
   "properties":
   {
    "marker-color":"#7e7e7e",
    "marker-size":"medium",
    "marker-symbol":""
   },
   "geometry":
   {
    "type":"Point",
    "coordinates":
    [
     8.6439871788025,
     49.2927841733937
    ]
   }
  }
 ]
}
```

More examples: see demo report ZGEOJSON_DEMO 

## License
This software is published under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)
