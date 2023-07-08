import 'dart:io';
//import 'dart:html';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLoc {
  PlaceLoc({required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;
}

class Place {
  Place(
      {required this.title,
      required this.image,
      required this.location,
      String? id})
      : id = id ?? uuid.v4();
  final String id;
  final String title;
  final File image;
  final PlaceLoc location;
}
