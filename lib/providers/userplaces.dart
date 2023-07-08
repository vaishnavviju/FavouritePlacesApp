import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favplacesapp/models/place.dart';
import 'package:path_provider/path_provider.dart' as sysp;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDB() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(p.join(dbPath, 'place.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT,lat REAL,lng REAL)');
  }, version: 1);

  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLoc location) async {
    final appDir = await sysp.getApplicationDocumentsDirectory();
    final filename = p.basename(image.path);
    final copyImg = await image.copy('${appDir.path}/$filename');
    final newPlace = Place(title: title, image: copyImg, location: location);
    final db = await _getDB();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude
    });

    state = [newPlace, ...state];
  }

  Future<void> loadPlace() async {
    final db = await _getDB();
    final data = await db.query('user_places');
    data.map((row) {
      return Place(
          id: row['id'] as String,
          title: row['title'] as String,
          image: File(row['image'] as String),
          location: PlaceLoc(
              latitude: row['lat'] as double, longitude: row['lng'] as double));
    });
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
