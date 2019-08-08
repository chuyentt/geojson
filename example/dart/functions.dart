import 'dart:io';
import 'package:geojson/geojson.dart';

// data is from http://www.naturalearthdata.com

void main() async {
  await smallData();
  await multipolygons();
  await lines();
}

Future<void> smallData() async {
  final file = File("../data/small_data.geojson");
  final features = await featuresFromGeoJsonFile(file);
  for (final feature in features.collection) {
    print("Point: ${feature.geometry.geoPoint.name}");
  }
  return;
}

Future<void> multipolygons() async {
  final file = File("../data/lakes_of_europe.geojson");
  final features = await featuresFromGeoJsonFile(file, nameProperty: "label");
  for (final feature in features.collection) {
    final geom = feature.geometry as GeoJsonMultiPolygon;
    for (final polygon in geom.polygons) {
      print("Polygon ${polygon.name}");
      for (final geoSerie in polygon.geoSeries) {
        print("- ${geoSerie.geoPoints.length} geopoints");
      }
    }
  }
}

Future<void> lines() async {
  final file = File("../data/railroads_of_north_america.geojson");
  final features = await featuresFromGeoJsonFile(file);
  for (final feature in features.collection) {
    print("${feature.geometry.geoSerie.name}: " +
        "${feature.geometry.geoSerie.geoPoints.length} geopoints");
  }
}
