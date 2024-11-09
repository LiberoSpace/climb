import 'package:climb/database/database.dart';
import 'package:drift/drift.dart';

class ClimbingProblemService {
  final AppDatabase db;

  ClimbingProblemService({required this.db});

  Future<List<ClimbingProblem>> getClimbingProblems(
      {required int exerciseRecordId}) async {
    try {
      var climbingProblemsSSS = db.select(db.climbingProblems);

      climbingProblemsSSS = (climbingProblemsSSS
        ..where((tbl) => tbl.exerciseRecord.equals(exerciseRecordId)));

      climbingProblemsSSS = (climbingProblemsSSS
        ..orderBy(
          [
            // 최신순 정렬. 예상 파일 명 2024.06.02_더클라임 연남
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                )
          ],
        ));

      var climbingProblems = await climbingProblemsSSS.get();

      return climbingProblems;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<ClimbingProblem?> getUnFinishedClimbingProblem() async {
    try {
      return await (db.select(db.climbingProblems)
            ..where((tbl) => tbl.isFinished.equals(false)))
          .getSingleOrNull();
    } catch (e) {
      rethrow;
    }
  }

  Future<ClimbingProblem> getClimbingProblem(int climbingProblemId) async {
    return await (db.select(db.climbingProblems)
          ..where((tbl) => tbl.id.equals(climbingProblemId)))
        .getSingle();
  }

  Future<int> createClimbingProblem({
    required int exerciseRecordId,
    required int difficultyId,
  }) async {
    try {
      return await db.into(db.climbingProblems).insert(
            ClimbingProblemsCompanion.insert(
              exerciseRecord: exerciseRecordId,
              difficulty: difficultyId,
            ),
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<int> updateClimbingProblem({
    required ClimbingProblem climbingProblem,
    bool? isSuccess,
    bool? isFinished,
    bool addTrialCount = false,
  }) async {
    try {
      return await (db.update(db.climbingProblems)
            ..where(
              (tbl) => tbl.id.equals(climbingProblem.id),
            ))
          .write(
        ClimbingProblemsCompanion(
          isSuccess:
              isSuccess != null ? Value(isSuccess) : const Value.absent(),
          isFinished:
              isFinished != null ? Value(isFinished) : const Value.absent(),
          trialCount: addTrialCount
              ? Value(climbingProblem.trialCount + 1)
              : const Value.absent(),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
