import 'package:climb/database/difficulties_table.dart';
import 'package:climb/database/locations_table.dart';
import 'package:climb/database/schema_versions.dart';
import 'package:climb/database/videos_table.dart';
import 'package:climb/database/climbing_problems_table.dart';
import 'package:climb/database/exercise_records_table.dart';

import 'package:drift/drift.dart';
import 'package:drift/internal/versioned_schema.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

// These additional imports are necessary to open the sqlite3 database
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

// 증분 재구축
// dart run build_runner watch
// 스키마 생성
// dart run drift_dev schema dump lib/database/database.dart drift_schemas/
// 업데이트 코드 생성
// dart run drift_dev schema steps drift_schemas/ lib/database/schema_versions.dart

@DriftDatabase(tables: [
  Videos,
  ExerciseRecords,
  ClimbingProblems,
  Locations,
  Difficulties
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.alterTable(TableMigration(
            schema.videos,
            columnTransformer: {
              schema.videos.isLike: const CustomExpression('like')
            },
          ));
        },
      ),
      beforeOpen: (details) async {
        if (kDebugMode) {
          print('이전 버전: ${details.versionBefore}');
          print('이전 버전: ${details.versionNow}');
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
