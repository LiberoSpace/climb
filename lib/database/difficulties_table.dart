import 'package:climb/database/locations_table.dart';
import 'package:drift/drift.dart';

class Difficulties extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get colorValue => integer()();
  IntColumn get score => integer()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
  IntColumn get location => integer().references(Locations, #id)();
}
