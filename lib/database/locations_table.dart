import 'package:drift/drift.dart';

class Locations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get locationUid => text()();
  TextColumn get locationName => text()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
