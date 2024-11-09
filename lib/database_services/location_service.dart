import 'package:climb/database/database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

class LocationService {
  final AppDatabase db;

  LocationService({required this.db});

  Future<Location> getLocation(int locationId) async {
    try {
      return await (db.select(db.locations)
            ..where((tbl) => tbl.id.equals(locationId)))
          .getSingle();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Location?> getLocationByLocationUid(String locationUid) async {
    try {
      return await (db.select(db.locations)
            ..where((tbl) => tbl.locationUid.equals(locationUid)))
          .getSingleOrNull();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int> createLocation({
    required String locationUid,
    required String locationName,
  }) async {
    try {
      var locationId = await db.into(db.locations).insert(
            LocationsCompanion.insert(
              locationUid: locationUid,
              locationName: locationName,
            ),
          );

      return locationId;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  updateLocation({
    required int locationId,
    String? locationName,
  }) async {
    try {
      await (db.update(db.locations)
            ..where(
              (tbl) => tbl.id.equals(locationId),
            ))
          .write(
        LocationsCompanion(
          locationName:
              locationName != null ? Value(locationName) : const Value.absent(),
        ),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
