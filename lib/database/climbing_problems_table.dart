import 'package:climb/database/difficulties_table.dart';
import 'package:climb/database/exercise_records_table.dart';
import 'package:drift/drift.dart';

class ClimbingProblems extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isSuccess => boolean().withDefault(const Constant(false))();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
  IntColumn get trialCount => integer().withDefault(const Constant(0))();
  IntColumn get exerciseRecord =>
      integer().references(ExerciseRecords, #id, onDelete: KeyAction.cascade)();
  IntColumn get difficulty =>
      integer().references(Difficulties, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
