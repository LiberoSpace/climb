import 'package:climb/database/climbing_problems_table.dart';
import 'package:climb/database/exercise_records_table.dart';
import 'package:drift/drift.dart';

class Videos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fileName => text()();
  BoolColumn get isLike => boolean().withDefault(const Constant(false))();
  BoolColumn get isSuccess => boolean().withDefault(const Constant(false))();
  IntColumn get trialNumber => integer()();
  IntColumn get climbingProblem =>
      integer().references(ClimbingProblems, #id)();
  IntColumn get exerciseRecord => integer().references(ExerciseRecords, #id)();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
