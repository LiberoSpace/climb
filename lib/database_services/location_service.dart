import 'package:climb/database/database.dart';
import 'package:drift/drift.dart';

class LocationService {
  final AppDatabase db;

  LocationService({required this.db});

  Future<List<Location>> getLocations({String? search}) async {
    try {
      if (search == null) {
        return await (db.select(db.locations)
              ..orderBy(
                [
                  // 최신순 정렬. 예상 파일 명 2024.06.02_더클라임 연남
                  (t) => OrderingTerm(
                        expression: t.locationName,
                        mode: OrderingMode.desc,
                      )
                ],
              ))
            .get();
      }
      if (search.contains('--')) {
        throw Exception('sql inject');
      }
      return await (db.select(db.locations)
            ..where((tbl) => tbl.locationName.like('%$search%')))
          .get();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

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
