import 'package:climb/database/locations_table.dart';
import 'package:drift/drift.dart';

class ExerciseRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fileName => text()();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
  IntColumn get location => integer().references(Locations, #id)();
}
