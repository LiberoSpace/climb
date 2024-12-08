// These additional imports are necessary to open the sqlite3 database
import 'dart:io';

import 'package:climb/database/climbing_problems_table.dart';
import 'package:climb/database/difficulties_table.dart';
import 'package:climb/database/exercise_records_table.dart';
import 'package:climb/database/locations_table.dart';
import 'package:climb/database/schema_versions.dart';
import 'package:climb/database/videos_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
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

        int locId;
        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_gangnam',
            locationName: '더클라임 강남',
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_nonhyeon',
            locationName: '더클라임 논현',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_magok',
            locationName: '더클라임 마곡',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_mullae',
            locationName: '더클라임 문래',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_sadang',
            locationName: '더클라임 사당',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_seouldae',
            locationName: '더클라임 서울대',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_sillim',
            locationName: '더클라임 신림',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_sinsa',
            locationName: '더클라임 신사',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_yangjae',
            locationName: '더클라임 양재',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_yeonnam',
            locationName: '더클라임 연남',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_leesoo',
            locationName: '더클라임 이수',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );

        locId = await into(locations).insert(
          LocationsCompanion.insert(
            locationUid: 'theclimb_ilsan',
            locationName: '더클라임 일산',
          ),
        );

        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '파랑',
            colorValue: int.parse('0xFF0000FF'),
            uid: '1',
            score: 500,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '회색',
            colorValue: int.parse('0xFFC0C0C0'),
            uid: '1',
            score: 1200,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '하양',
            colorValue: int.parse('0xFFFFFFFF'),
            uid: '1',
            score: 10,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '주황',
            colorValue: int.parse('0xFFFFA500'),
            uid: '1',
            score: 100,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '노랑',
            colorValue: int.parse('0xFFFFFF00'),
            uid: '1',
            score: 30,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '초록',
            colorValue: int.parse('0xFF008000'),
            uid: '1',
            score: 250,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '검정',
            colorValue: int.parse('0xFF000000'),
            uid: '1',
            score: 1400,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '갈색',
            colorValue: int.parse('0xFF8B4513'),
            uid: '1',
            score: 1600,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '빨강',
            colorValue: int.parse('0xFFFF0000'),
            uid: '1',
            score: 800,
            location: locId,
          ),
        );
        await into(difficulties).insert(
          DifficultiesCompanion.insert(
            name: '보라',
            colorValue: int.parse('0xFF800080'),
            uid: '1',
            score: 1000,
            location: locId,
          ),
        );
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
