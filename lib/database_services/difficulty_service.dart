import 'package:climb/database/database.dart';
import 'package:climb/database_services/exercise_record_service.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

class DifficultyService {
  final AppDatabase db;

  DifficultyService({required this.db});

  Future<Difficulty> getDifficulty(int difficultyId) async {
    try {
      var query = db.select(db.difficulties)
        ..where(
          (tbl) => tbl.id.equals(difficultyId),
        );

      return await query.getSingle();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Difficulty> getLatestDifficultyByExerciseRecordWithJoin(
      ExerciseRecordWithJoin exerciseRecordWithJoin) async {
    try {
      var query = db.select(db.climbingProblems).join([
        innerJoin(
          db.difficulties,
          db.difficulties.id.equalsExp(
            db.climbingProblems.difficulty,
          ),
        )
      ])
        ..where(
          db.climbingProblems.exerciseRecord
              .equals(exerciseRecordWithJoin.exerciseRecord.id),
        )
        ..orderBy(
          [
            OrderingTerm(
              expression: db.climbingProblems.createdAt,
              mode: OrderingMode.desc,
            ),
          ],
        )
        ..limit(1);
      var climbingProblems = await query.get();

      if (climbingProblems.isEmpty) {
        return (await getDifficulties(
          exerciseRecordWithJoin.location.id,
        ))[0];
      } else {
        // 가장 마지막 문제 존재하면 가져옴
        return climbingProblems[0].readTable(db.difficulties);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Difficulty>> getDifficulties(int locationId) async {
    try {
      var query = db.select(db.difficulties)
        ..where(
          (tbl) => tbl.location.equals(locationId),
        )
        ..orderBy(
          [
            (t) => OrderingTerm(
                  expression: t.score,
                  mode: OrderingMode.asc,
                )
          ],
        );

      return await query.get();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> createDifficulty({
    required String uid,
    required String name,
    required int colorValue,
    required int score,
    required int locationId,
  }) async {
    try {
      var recordId = await db.into(db.difficulties).insert(
            DifficultiesCompanion.insert(
              uid: uid,
              name: name,
              colorValue: colorValue,
              score: score,
              location: locationId,
            ),
          );

      return recordId;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  updateDifficulty({
    required int difficultyId,
    String? name,
    int? colorValue,
    int? score,
    int? locationId,
    bool? isActive,
  }) async {
    try {
      return await (db.update(db.difficulties)
            ..where(
              (tbl) => tbl.id.equals(difficultyId),
            ))
          .write(
        DifficultiesCompanion(
          name: name != null ? Value(name) : const Value.absent(),
          colorValue:
              colorValue != null ? Value(colorValue) : const Value.absent(),
          score: score != null ? Value(score) : const Value.absent(),
          location:
              locationId != null ? Value(locationId) : const Value.absent(),
          isActive: isActive != null ? Value(isActive) : const Value.absent(),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
