// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _locationUidMeta =
      const VerificationMeta('locationUid');
  @override
  late final GeneratedColumn<String> locationUid = GeneratedColumn<String>(
      'location_uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationNameMeta =
      const VerificationMeta('locationName');
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
      'location_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [id, locationUid, locationName, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(Insertable<Location> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('location_uid')) {
      context.handle(
          _locationUidMeta,
          locationUid.isAcceptableOrUnknown(
              data['location_uid']!, _locationUidMeta));
    } else if (isInserting) {
      context.missing(_locationUidMeta);
    }
    if (data.containsKey('location_name')) {
      context.handle(
          _locationNameMeta,
          locationName.isAcceptableOrUnknown(
              data['location_name']!, _locationNameMeta));
    } else if (isInserting) {
      context.missing(_locationNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      locationUid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_uid'])!,
      locationName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final int id;
  final String locationUid;
  final String locationName;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Location(
      {required this.id,
      required this.locationUid,
      required this.locationName,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['location_uid'] = Variable<String>(locationUid);
    map['location_name'] = Variable<String>(locationName);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      locationUid: Value(locationUid),
      locationName: Value(locationName),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<int>(json['id']),
      locationUid: serializer.fromJson<String>(json['locationUid']),
      locationName: serializer.fromJson<String>(json['locationName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'locationUid': serializer.toJson<String>(locationUid),
      'locationName': serializer.toJson<String>(locationName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Location copyWith(
          {int? id,
          String? locationUid,
          String? locationName,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Location(
        id: id ?? this.id,
        locationUid: locationUid ?? this.locationUid,
        locationName: locationName ?? this.locationName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      id: data.id.present ? data.id.value : this.id,
      locationUid:
          data.locationUid.present ? data.locationUid.value : this.locationUid,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('locationUid: $locationUid, ')
          ..write('locationName: $locationName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, locationUid, locationName, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.locationUid == this.locationUid &&
          other.locationName == this.locationName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<int> id;
  final Value<String> locationUid;
  final Value<String> locationName;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.locationUid = const Value.absent(),
    this.locationName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocationsCompanion.insert({
    this.id = const Value.absent(),
    required String locationUid,
    required String locationName,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : locationUid = Value(locationUid),
        locationName = Value(locationName);
  static Insertable<Location> custom({
    Expression<int>? id,
    Expression<String>? locationUid,
    Expression<String>? locationName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (locationUid != null) 'location_uid': locationUid,
      if (locationName != null) 'location_name': locationName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? locationUid,
      Value<String>? locationName,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return LocationsCompanion(
      id: id ?? this.id,
      locationUid: locationUid ?? this.locationUid,
      locationName: locationName ?? this.locationName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (locationUid.present) {
      map['location_uid'] = Variable<String>(locationUid.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('locationUid: $locationUid, ')
          ..write('locationName: $locationName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ExerciseRecordsTable extends ExerciseRecords
    with TableInfo<$ExerciseRecordsTable, ExerciseRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFinishedMeta =
      const VerificationMeta('isFinished');
  @override
  late final GeneratedColumn<bool> isFinished = GeneratedColumn<bool>(
      'is_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_finished" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<int> location = GeneratedColumn<int>(
      'location', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES locations (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, fileName, isFinished, createdAt, updatedAt, location];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_records';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('is_finished')) {
      context.handle(
          _isFinishedMeta,
          isFinished.isAcceptableOrUnknown(
              data['is_finished']!, _isFinishedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      isFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_finished'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}location'])!,
    );
  }

  @override
  $ExerciseRecordsTable createAlias(String alias) {
    return $ExerciseRecordsTable(attachedDatabase, alias);
  }
}

class ExerciseRecord extends DataClass implements Insertable<ExerciseRecord> {
  final int id;
  final String fileName;
  final bool isFinished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int location;
  const ExerciseRecord(
      {required this.id,
      required this.fileName,
      required this.isFinished,
      required this.createdAt,
      required this.updatedAt,
      required this.location});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_name'] = Variable<String>(fileName);
    map['is_finished'] = Variable<bool>(isFinished);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['location'] = Variable<int>(location);
    return map;
  }

  ExerciseRecordsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseRecordsCompanion(
      id: Value(id),
      fileName: Value(fileName),
      isFinished: Value(isFinished),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      location: Value(location),
    );
  }

  factory ExerciseRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseRecord(
      id: serializer.fromJson<int>(json['id']),
      fileName: serializer.fromJson<String>(json['fileName']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      location: serializer.fromJson<int>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileName': serializer.toJson<String>(fileName),
      'isFinished': serializer.toJson<bool>(isFinished),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'location': serializer.toJson<int>(location),
    };
  }

  ExerciseRecord copyWith(
          {int? id,
          String? fileName,
          bool? isFinished,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? location}) =>
      ExerciseRecord(
        id: id ?? this.id,
        fileName: fileName ?? this.fileName,
        isFinished: isFinished ?? this.isFinished,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        location: location ?? this.location,
      );
  ExerciseRecord copyWithCompanion(ExerciseRecordsCompanion data) {
    return ExerciseRecord(
      id: data.id.present ? data.id.value : this.id,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      isFinished:
          data.isFinished.present ? data.isFinished.value : this.isFinished,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      location: data.location.present ? data.location.value : this.location,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRecord(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('isFinished: $isFinished, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fileName, isFinished, createdAt, updatedAt, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseRecord &&
          other.id == this.id &&
          other.fileName == this.fileName &&
          other.isFinished == this.isFinished &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.location == this.location);
}

class ExerciseRecordsCompanion extends UpdateCompanion<ExerciseRecord> {
  final Value<int> id;
  final Value<String> fileName;
  final Value<bool> isFinished;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> location;
  const ExerciseRecordsCompanion({
    this.id = const Value.absent(),
    this.fileName = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.location = const Value.absent(),
  });
  ExerciseRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String fileName,
    this.isFinished = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int location,
  })  : fileName = Value(fileName),
        location = Value(location);
  static Insertable<ExerciseRecord> custom({
    Expression<int>? id,
    Expression<String>? fileName,
    Expression<bool>? isFinished,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? location,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileName != null) 'file_name': fileName,
      if (isFinished != null) 'is_finished': isFinished,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (location != null) 'location': location,
    });
  }

  ExerciseRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? fileName,
      Value<bool>? isFinished,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? location}) {
    return ExerciseRecordsCompanion(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      isFinished: isFinished ?? this.isFinished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      location: location ?? this.location,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<bool>(isFinished.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (location.present) {
      map['location'] = Variable<int>(location.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRecordsCompanion(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('isFinished: $isFinished, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }
}

class $DifficultiesTable extends Difficulties
    with TableInfo<$DifficultiesTable, Difficulty> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DifficultiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<int> location = GeneratedColumn<int>(
      'location', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES locations (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, colorValue, score, isActive, createdAt, updatedAt, location];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'difficulties';
  @override
  VerificationContext validateIntegrity(Insertable<Difficulty> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Difficulty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Difficulty(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}location'])!,
    );
  }

  @override
  $DifficultiesTable createAlias(String alias) {
    return $DifficultiesTable(attachedDatabase, alias);
  }
}

class Difficulty extends DataClass implements Insertable<Difficulty> {
  final int id;
  final String name;
  final int colorValue;
  final int score;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int location;
  const Difficulty(
      {required this.id,
      required this.name,
      required this.colorValue,
      required this.score,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt,
      required this.location});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color_value'] = Variable<int>(colorValue);
    map['score'] = Variable<int>(score);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['location'] = Variable<int>(location);
    return map;
  }

  DifficultiesCompanion toCompanion(bool nullToAbsent) {
    return DifficultiesCompanion(
      id: Value(id),
      name: Value(name),
      colorValue: Value(colorValue),
      score: Value(score),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      location: Value(location),
    );
  }

  factory Difficulty.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Difficulty(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      score: serializer.fromJson<int>(json['score']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      location: serializer.fromJson<int>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'colorValue': serializer.toJson<int>(colorValue),
      'score': serializer.toJson<int>(score),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'location': serializer.toJson<int>(location),
    };
  }

  Difficulty copyWith(
          {int? id,
          String? name,
          int? colorValue,
          int? score,
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? location}) =>
      Difficulty(
        id: id ?? this.id,
        name: name ?? this.name,
        colorValue: colorValue ?? this.colorValue,
        score: score ?? this.score,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        location: location ?? this.location,
      );
  Difficulty copyWithCompanion(DifficultiesCompanion data) {
    return Difficulty(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      score: data.score.present ? data.score.value : this.score,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      location: data.location.present ? data.location.value : this.location,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Difficulty(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('score: $score, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, colorValue, score, isActive, createdAt, updatedAt, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Difficulty &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorValue == this.colorValue &&
          other.score == this.score &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.location == this.location);
}

class DifficultiesCompanion extends UpdateCompanion<Difficulty> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> colorValue;
  final Value<int> score;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> location;
  const DifficultiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.score = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.location = const Value.absent(),
  });
  DifficultiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int colorValue,
    required int score,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int location,
  })  : name = Value(name),
        colorValue = Value(colorValue),
        score = Value(score),
        location = Value(location);
  static Insertable<Difficulty> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? colorValue,
    Expression<int>? score,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? location,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorValue != null) 'color_value': colorValue,
      if (score != null) 'score': score,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (location != null) 'location': location,
    });
  }

  DifficultiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? colorValue,
      Value<int>? score,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? location}) {
    return DifficultiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      score: score ?? this.score,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      location: location ?? this.location,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (location.present) {
      map['location'] = Variable<int>(location.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DifficultiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('score: $score, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }
}

class $ClimbingProblemsTable extends ClimbingProblems
    with TableInfo<$ClimbingProblemsTable, ClimbingProblem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClimbingProblemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _isSuccessMeta =
      const VerificationMeta('isSuccess');
  @override
  late final GeneratedColumn<bool> isSuccess = GeneratedColumn<bool>(
      'is_success', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_success" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isFinishedMeta =
      const VerificationMeta('isFinished');
  @override
  late final GeneratedColumn<bool> isFinished = GeneratedColumn<bool>(
      'is_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_finished" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _trialCountMeta =
      const VerificationMeta('trialCount');
  @override
  late final GeneratedColumn<int> trialCount = GeneratedColumn<int>(
      'trial_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _exerciseRecordMeta =
      const VerificationMeta('exerciseRecord');
  @override
  late final GeneratedColumn<int> exerciseRecord = GeneratedColumn<int>(
      'exercise_record', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exercise_records (id) ON DELETE CASCADE'));
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES difficulties (id) ON DELETE CASCADE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        isSuccess,
        isFinished,
        trialCount,
        exerciseRecord,
        difficulty,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'climbing_problems';
  @override
  VerificationContext validateIntegrity(Insertable<ClimbingProblem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_success')) {
      context.handle(_isSuccessMeta,
          isSuccess.isAcceptableOrUnknown(data['is_success']!, _isSuccessMeta));
    }
    if (data.containsKey('is_finished')) {
      context.handle(
          _isFinishedMeta,
          isFinished.isAcceptableOrUnknown(
              data['is_finished']!, _isFinishedMeta));
    }
    if (data.containsKey('trial_count')) {
      context.handle(
          _trialCountMeta,
          trialCount.isAcceptableOrUnknown(
              data['trial_count']!, _trialCountMeta));
    }
    if (data.containsKey('exercise_record')) {
      context.handle(
          _exerciseRecordMeta,
          exerciseRecord.isAcceptableOrUnknown(
              data['exercise_record']!, _exerciseRecordMeta));
    } else if (isInserting) {
      context.missing(_exerciseRecordMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClimbingProblem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClimbingProblem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      isSuccess: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_success'])!,
      isFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_finished'])!,
      trialCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trial_count'])!,
      exerciseRecord: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_record'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}difficulty'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ClimbingProblemsTable createAlias(String alias) {
    return $ClimbingProblemsTable(attachedDatabase, alias);
  }
}

class ClimbingProblem extends DataClass implements Insertable<ClimbingProblem> {
  final int id;
  final bool isSuccess;
  final bool isFinished;
  final int trialCount;
  final int exerciseRecord;
  final int difficulty;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ClimbingProblem(
      {required this.id,
      required this.isSuccess,
      required this.isFinished,
      required this.trialCount,
      required this.exerciseRecord,
      required this.difficulty,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_success'] = Variable<bool>(isSuccess);
    map['is_finished'] = Variable<bool>(isFinished);
    map['trial_count'] = Variable<int>(trialCount);
    map['exercise_record'] = Variable<int>(exerciseRecord);
    map['difficulty'] = Variable<int>(difficulty);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClimbingProblemsCompanion toCompanion(bool nullToAbsent) {
    return ClimbingProblemsCompanion(
      id: Value(id),
      isSuccess: Value(isSuccess),
      isFinished: Value(isFinished),
      trialCount: Value(trialCount),
      exerciseRecord: Value(exerciseRecord),
      difficulty: Value(difficulty),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ClimbingProblem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClimbingProblem(
      id: serializer.fromJson<int>(json['id']),
      isSuccess: serializer.fromJson<bool>(json['isSuccess']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
      trialCount: serializer.fromJson<int>(json['trialCount']),
      exerciseRecord: serializer.fromJson<int>(json['exerciseRecord']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isSuccess': serializer.toJson<bool>(isSuccess),
      'isFinished': serializer.toJson<bool>(isFinished),
      'trialCount': serializer.toJson<int>(trialCount),
      'exerciseRecord': serializer.toJson<int>(exerciseRecord),
      'difficulty': serializer.toJson<int>(difficulty),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ClimbingProblem copyWith(
          {int? id,
          bool? isSuccess,
          bool? isFinished,
          int? trialCount,
          int? exerciseRecord,
          int? difficulty,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ClimbingProblem(
        id: id ?? this.id,
        isSuccess: isSuccess ?? this.isSuccess,
        isFinished: isFinished ?? this.isFinished,
        trialCount: trialCount ?? this.trialCount,
        exerciseRecord: exerciseRecord ?? this.exerciseRecord,
        difficulty: difficulty ?? this.difficulty,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ClimbingProblem copyWithCompanion(ClimbingProblemsCompanion data) {
    return ClimbingProblem(
      id: data.id.present ? data.id.value : this.id,
      isSuccess: data.isSuccess.present ? data.isSuccess.value : this.isSuccess,
      isFinished:
          data.isFinished.present ? data.isFinished.value : this.isFinished,
      trialCount:
          data.trialCount.present ? data.trialCount.value : this.trialCount,
      exerciseRecord: data.exerciseRecord.present
          ? data.exerciseRecord.value
          : this.exerciseRecord,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClimbingProblem(')
          ..write('id: $id, ')
          ..write('isSuccess: $isSuccess, ')
          ..write('isFinished: $isFinished, ')
          ..write('trialCount: $trialCount, ')
          ..write('exerciseRecord: $exerciseRecord, ')
          ..write('difficulty: $difficulty, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, isSuccess, isFinished, trialCount,
      exerciseRecord, difficulty, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClimbingProblem &&
          other.id == this.id &&
          other.isSuccess == this.isSuccess &&
          other.isFinished == this.isFinished &&
          other.trialCount == this.trialCount &&
          other.exerciseRecord == this.exerciseRecord &&
          other.difficulty == this.difficulty &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClimbingProblemsCompanion extends UpdateCompanion<ClimbingProblem> {
  final Value<int> id;
  final Value<bool> isSuccess;
  final Value<bool> isFinished;
  final Value<int> trialCount;
  final Value<int> exerciseRecord;
  final Value<int> difficulty;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ClimbingProblemsCompanion({
    this.id = const Value.absent(),
    this.isSuccess = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.trialCount = const Value.absent(),
    this.exerciseRecord = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ClimbingProblemsCompanion.insert({
    this.id = const Value.absent(),
    this.isSuccess = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.trialCount = const Value.absent(),
    required int exerciseRecord,
    required int difficulty,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : exerciseRecord = Value(exerciseRecord),
        difficulty = Value(difficulty);
  static Insertable<ClimbingProblem> custom({
    Expression<int>? id,
    Expression<bool>? isSuccess,
    Expression<bool>? isFinished,
    Expression<int>? trialCount,
    Expression<int>? exerciseRecord,
    Expression<int>? difficulty,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isSuccess != null) 'is_success': isSuccess,
      if (isFinished != null) 'is_finished': isFinished,
      if (trialCount != null) 'trial_count': trialCount,
      if (exerciseRecord != null) 'exercise_record': exerciseRecord,
      if (difficulty != null) 'difficulty': difficulty,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ClimbingProblemsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? isSuccess,
      Value<bool>? isFinished,
      Value<int>? trialCount,
      Value<int>? exerciseRecord,
      Value<int>? difficulty,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ClimbingProblemsCompanion(
      id: id ?? this.id,
      isSuccess: isSuccess ?? this.isSuccess,
      isFinished: isFinished ?? this.isFinished,
      trialCount: trialCount ?? this.trialCount,
      exerciseRecord: exerciseRecord ?? this.exerciseRecord,
      difficulty: difficulty ?? this.difficulty,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isSuccess.present) {
      map['is_success'] = Variable<bool>(isSuccess.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<bool>(isFinished.value);
    }
    if (trialCount.present) {
      map['trial_count'] = Variable<int>(trialCount.value);
    }
    if (exerciseRecord.present) {
      map['exercise_record'] = Variable<int>(exerciseRecord.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClimbingProblemsCompanion(')
          ..write('id: $id, ')
          ..write('isSuccess: $isSuccess, ')
          ..write('isFinished: $isFinished, ')
          ..write('trialCount: $trialCount, ')
          ..write('exerciseRecord: $exerciseRecord, ')
          ..write('difficulty: $difficulty, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $VideosTable extends Videos with TableInfo<$VideosTable, Video> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isLikeMeta = const VerificationMeta('isLike');
  @override
  late final GeneratedColumn<bool> isLike = GeneratedColumn<bool>(
      'is_like', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_like" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isSuccessMeta =
      const VerificationMeta('isSuccess');
  @override
  late final GeneratedColumn<bool> isSuccess = GeneratedColumn<bool>(
      'is_success', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_success" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _trialNumberMeta =
      const VerificationMeta('trialNumber');
  @override
  late final GeneratedColumn<int> trialNumber = GeneratedColumn<int>(
      'trial_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _climbingProblemMeta =
      const VerificationMeta('climbingProblem');
  @override
  late final GeneratedColumn<int> climbingProblem = GeneratedColumn<int>(
      'climbing_problem', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES climbing_problems (id)'));
  static const VerificationMeta _exerciseRecordMeta =
      const VerificationMeta('exerciseRecord');
  @override
  late final GeneratedColumn<int> exerciseRecord = GeneratedColumn<int>(
      'exercise_record', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exercise_records (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fileName,
        isLike,
        isSuccess,
        trialNumber,
        climbingProblem,
        exerciseRecord,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'videos';
  @override
  VerificationContext validateIntegrity(Insertable<Video> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('is_like')) {
      context.handle(_isLikeMeta,
          isLike.isAcceptableOrUnknown(data['is_like']!, _isLikeMeta));
    }
    if (data.containsKey('is_success')) {
      context.handle(_isSuccessMeta,
          isSuccess.isAcceptableOrUnknown(data['is_success']!, _isSuccessMeta));
    }
    if (data.containsKey('trial_number')) {
      context.handle(
          _trialNumberMeta,
          trialNumber.isAcceptableOrUnknown(
              data['trial_number']!, _trialNumberMeta));
    } else if (isInserting) {
      context.missing(_trialNumberMeta);
    }
    if (data.containsKey('climbing_problem')) {
      context.handle(
          _climbingProblemMeta,
          climbingProblem.isAcceptableOrUnknown(
              data['climbing_problem']!, _climbingProblemMeta));
    } else if (isInserting) {
      context.missing(_climbingProblemMeta);
    }
    if (data.containsKey('exercise_record')) {
      context.handle(
          _exerciseRecordMeta,
          exerciseRecord.isAcceptableOrUnknown(
              data['exercise_record']!, _exerciseRecordMeta));
    } else if (isInserting) {
      context.missing(_exerciseRecordMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Video map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Video(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      isLike: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_like'])!,
      isSuccess: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_success'])!,
      trialNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trial_number'])!,
      climbingProblem: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}climbing_problem'])!,
      exerciseRecord: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_record'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $VideosTable createAlias(String alias) {
    return $VideosTable(attachedDatabase, alias);
  }
}

class Video extends DataClass implements Insertable<Video> {
  final int id;
  final String fileName;
  final bool isLike;
  final bool isSuccess;
  final int trialNumber;
  final int climbingProblem;
  final int exerciseRecord;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Video(
      {required this.id,
      required this.fileName,
      required this.isLike,
      required this.isSuccess,
      required this.trialNumber,
      required this.climbingProblem,
      required this.exerciseRecord,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_name'] = Variable<String>(fileName);
    map['is_like'] = Variable<bool>(isLike);
    map['is_success'] = Variable<bool>(isSuccess);
    map['trial_number'] = Variable<int>(trialNumber);
    map['climbing_problem'] = Variable<int>(climbingProblem);
    map['exercise_record'] = Variable<int>(exerciseRecord);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VideosCompanion toCompanion(bool nullToAbsent) {
    return VideosCompanion(
      id: Value(id),
      fileName: Value(fileName),
      isLike: Value(isLike),
      isSuccess: Value(isSuccess),
      trialNumber: Value(trialNumber),
      climbingProblem: Value(climbingProblem),
      exerciseRecord: Value(exerciseRecord),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Video.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Video(
      id: serializer.fromJson<int>(json['id']),
      fileName: serializer.fromJson<String>(json['fileName']),
      isLike: serializer.fromJson<bool>(json['isLike']),
      isSuccess: serializer.fromJson<bool>(json['isSuccess']),
      trialNumber: serializer.fromJson<int>(json['trialNumber']),
      climbingProblem: serializer.fromJson<int>(json['climbingProblem']),
      exerciseRecord: serializer.fromJson<int>(json['exerciseRecord']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileName': serializer.toJson<String>(fileName),
      'isLike': serializer.toJson<bool>(isLike),
      'isSuccess': serializer.toJson<bool>(isSuccess),
      'trialNumber': serializer.toJson<int>(trialNumber),
      'climbingProblem': serializer.toJson<int>(climbingProblem),
      'exerciseRecord': serializer.toJson<int>(exerciseRecord),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Video copyWith(
          {int? id,
          String? fileName,
          bool? isLike,
          bool? isSuccess,
          int? trialNumber,
          int? climbingProblem,
          int? exerciseRecord,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Video(
        id: id ?? this.id,
        fileName: fileName ?? this.fileName,
        isLike: isLike ?? this.isLike,
        isSuccess: isSuccess ?? this.isSuccess,
        trialNumber: trialNumber ?? this.trialNumber,
        climbingProblem: climbingProblem ?? this.climbingProblem,
        exerciseRecord: exerciseRecord ?? this.exerciseRecord,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Video copyWithCompanion(VideosCompanion data) {
    return Video(
      id: data.id.present ? data.id.value : this.id,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      isLike: data.isLike.present ? data.isLike.value : this.isLike,
      isSuccess: data.isSuccess.present ? data.isSuccess.value : this.isSuccess,
      trialNumber:
          data.trialNumber.present ? data.trialNumber.value : this.trialNumber,
      climbingProblem: data.climbingProblem.present
          ? data.climbingProblem.value
          : this.climbingProblem,
      exerciseRecord: data.exerciseRecord.present
          ? data.exerciseRecord.value
          : this.exerciseRecord,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Video(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('isLike: $isLike, ')
          ..write('isSuccess: $isSuccess, ')
          ..write('trialNumber: $trialNumber, ')
          ..write('climbingProblem: $climbingProblem, ')
          ..write('exerciseRecord: $exerciseRecord, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fileName, isLike, isSuccess, trialNumber,
      climbingProblem, exerciseRecord, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Video &&
          other.id == this.id &&
          other.fileName == this.fileName &&
          other.isLike == this.isLike &&
          other.isSuccess == this.isSuccess &&
          other.trialNumber == this.trialNumber &&
          other.climbingProblem == this.climbingProblem &&
          other.exerciseRecord == this.exerciseRecord &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VideosCompanion extends UpdateCompanion<Video> {
  final Value<int> id;
  final Value<String> fileName;
  final Value<bool> isLike;
  final Value<bool> isSuccess;
  final Value<int> trialNumber;
  final Value<int> climbingProblem;
  final Value<int> exerciseRecord;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const VideosCompanion({
    this.id = const Value.absent(),
    this.fileName = const Value.absent(),
    this.isLike = const Value.absent(),
    this.isSuccess = const Value.absent(),
    this.trialNumber = const Value.absent(),
    this.climbingProblem = const Value.absent(),
    this.exerciseRecord = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VideosCompanion.insert({
    this.id = const Value.absent(),
    required String fileName,
    this.isLike = const Value.absent(),
    this.isSuccess = const Value.absent(),
    required int trialNumber,
    required int climbingProblem,
    required int exerciseRecord,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : fileName = Value(fileName),
        trialNumber = Value(trialNumber),
        climbingProblem = Value(climbingProblem),
        exerciseRecord = Value(exerciseRecord);
  static Insertable<Video> custom({
    Expression<int>? id,
    Expression<String>? fileName,
    Expression<bool>? isLike,
    Expression<bool>? isSuccess,
    Expression<int>? trialNumber,
    Expression<int>? climbingProblem,
    Expression<int>? exerciseRecord,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileName != null) 'file_name': fileName,
      if (isLike != null) 'is_like': isLike,
      if (isSuccess != null) 'is_success': isSuccess,
      if (trialNumber != null) 'trial_number': trialNumber,
      if (climbingProblem != null) 'climbing_problem': climbingProblem,
      if (exerciseRecord != null) 'exercise_record': exerciseRecord,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  VideosCompanion copyWith(
      {Value<int>? id,
      Value<String>? fileName,
      Value<bool>? isLike,
      Value<bool>? isSuccess,
      Value<int>? trialNumber,
      Value<int>? climbingProblem,
      Value<int>? exerciseRecord,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return VideosCompanion(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      isLike: isLike ?? this.isLike,
      isSuccess: isSuccess ?? this.isSuccess,
      trialNumber: trialNumber ?? this.trialNumber,
      climbingProblem: climbingProblem ?? this.climbingProblem,
      exerciseRecord: exerciseRecord ?? this.exerciseRecord,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (isLike.present) {
      map['is_like'] = Variable<bool>(isLike.value);
    }
    if (isSuccess.present) {
      map['is_success'] = Variable<bool>(isSuccess.value);
    }
    if (trialNumber.present) {
      map['trial_number'] = Variable<int>(trialNumber.value);
    }
    if (climbingProblem.present) {
      map['climbing_problem'] = Variable<int>(climbingProblem.value);
    }
    if (exerciseRecord.present) {
      map['exercise_record'] = Variable<int>(exerciseRecord.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideosCompanion(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('isLike: $isLike, ')
          ..write('isSuccess: $isSuccess, ')
          ..write('trialNumber: $trialNumber, ')
          ..write('climbingProblem: $climbingProblem, ')
          ..write('exerciseRecord: $exerciseRecord, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $ExerciseRecordsTable exerciseRecords =
      $ExerciseRecordsTable(this);
  late final $DifficultiesTable difficulties = $DifficultiesTable(this);
  late final $ClimbingProblemsTable climbingProblems =
      $ClimbingProblemsTable(this);
  late final $VideosTable videos = $VideosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [locations, exerciseRecords, difficulties, climbingProblems, videos];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('exercise_records',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('climbing_problems', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('difficulties',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('climbing_problems', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$LocationsTableCreateCompanionBuilder = LocationsCompanion Function({
  Value<int> id,
  required String locationUid,
  required String locationName,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$LocationsTableUpdateCompanionBuilder = LocationsCompanion Function({
  Value<int> id,
  Value<String> locationUid,
  Value<String> locationName,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$LocationsTableReferences
    extends BaseReferences<_$AppDatabase, $LocationsTable, Location> {
  $$LocationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExerciseRecordsTable, List<ExerciseRecord>>
      _exerciseRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.exerciseRecords,
              aliasName: $_aliasNameGenerator(
                  db.locations.id, db.exerciseRecords.location));

  $$ExerciseRecordsTableProcessedTableManager get exerciseRecordsRefs {
    final manager =
        $$ExerciseRecordsTableTableManager($_db, $_db.exerciseRecords)
            .filter((f) => f.location.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_exerciseRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DifficultiesTable, List<Difficulty>>
      _difficultiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.difficulties,
          aliasName:
              $_aliasNameGenerator(db.locations.id, db.difficulties.location));

  $$DifficultiesTableProcessedTableManager get difficultiesRefs {
    final manager = $$DifficultiesTableTableManager($_db, $_db.difficulties)
        .filter((f) => f.location.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_difficultiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LocationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationUid => $composableBuilder(
      column: $table.locationUid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationName => $composableBuilder(
      column: $table.locationName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> exerciseRecordsRefs(
      Expression<bool> Function($$ExerciseRecordsTableFilterComposer f) f) {
    final $$ExerciseRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseRecords,
        getReferencedColumn: (t) => t.location,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseRecordsTableFilterComposer(
              $db: $db,
              $table: $db.exerciseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> difficultiesRefs(
      Expression<bool> Function($$DifficultiesTableFilterComposer f) f) {
    final $$DifficultiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.difficulties,
        getReferencedColumn: (t) => t.location,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DifficultiesTableFilterComposer(
              $db: $db,
              $table: $db.difficulties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationUid => $composableBuilder(
      column: $table.locationUid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationName => $composableBuilder(
      column: $table.locationName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get locationUid => $composableBuilder(
      column: $table.locationUid, builder: (column) => column);

  GeneratedColumn<String> get locationName => $composableBuilder(
      column: $table.locationName, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> exerciseRecordsRefs<T extends Object>(
      Expression<T> Function($$ExerciseRecordsTableAnnotationComposer a) f) {
    final $$ExerciseRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exerciseRecords,
        getReferencedColumn: (t) => t.location,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.exerciseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> difficultiesRefs<T extends Object>(
      Expression<T> Function($$DifficultiesTableAnnotationComposer a) f) {
    final $$DifficultiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.difficulties,
        getReferencedColumn: (t) => t.location,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DifficultiesTableAnnotationComposer(
              $db: $db,
              $table: $db.difficulties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocationsTable,
    Location,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (Location, $$LocationsTableReferences),
    Location,
    PrefetchHooks Function({bool exerciseRecordsRefs, bool difficultiesRefs})> {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> locationUid = const Value.absent(),
            Value<String> locationName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LocationsCompanion(
            id: id,
            locationUid: locationUid,
            locationName: locationName,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String locationUid,
            required String locationName,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              LocationsCompanion.insert(
            id: id,
            locationUid: locationUid,
            locationName: locationName,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {exerciseRecordsRefs = false, difficultiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (exerciseRecordsRefs) db.exerciseRecords,
                if (difficultiesRefs) db.difficulties
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exerciseRecordsRefs)
                    await $_getPrefetchedData<Location, $LocationsTable,
                            ExerciseRecord>(
                        currentTable: table,
                        referencedTable: $$LocationsTableReferences
                            ._exerciseRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocationsTableReferences(db, table, p0)
                                .exerciseRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.location == item.id),
                        typedResults: items),
                  if (difficultiesRefs)
                    await $_getPrefetchedData<Location, $LocationsTable,
                            Difficulty>(
                        currentTable: table,
                        referencedTable: $$LocationsTableReferences
                            ._difficultiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocationsTableReferences(db, table, p0)
                                .difficultiesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.location == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocationsTable,
    Location,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (Location, $$LocationsTableReferences),
    Location,
    PrefetchHooks Function({bool exerciseRecordsRefs, bool difficultiesRefs})>;
typedef $$ExerciseRecordsTableCreateCompanionBuilder = ExerciseRecordsCompanion
    Function({
  Value<int> id,
  required String fileName,
  Value<bool> isFinished,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required int location,
});
typedef $$ExerciseRecordsTableUpdateCompanionBuilder = ExerciseRecordsCompanion
    Function({
  Value<int> id,
  Value<String> fileName,
  Value<bool> isFinished,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> location,
});

final class $$ExerciseRecordsTableReferences extends BaseReferences<
    _$AppDatabase, $ExerciseRecordsTable, ExerciseRecord> {
  $$ExerciseRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocationsTable _locationTable(_$AppDatabase db) =>
      db.locations.createAlias(
          $_aliasNameGenerator(db.exerciseRecords.location, db.locations.id));

  $$LocationsTableProcessedTableManager get location {
    final $_column = $_itemColumn<int>('location')!;

    final manager = $$LocationsTableTableManager($_db, $_db.locations)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_locationTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ClimbingProblemsTable, List<ClimbingProblem>>
      _climbingProblemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.climbingProblems,
              aliasName: $_aliasNameGenerator(
                  db.exerciseRecords.id, db.climbingProblems.exerciseRecord));

  $$ClimbingProblemsTableProcessedTableManager get climbingProblemsRefs {
    final manager = $$ClimbingProblemsTableTableManager(
            $_db, $_db.climbingProblems)
        .filter((f) => f.exerciseRecord.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_climbingProblemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$VideosTable, List<Video>> _videosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.videos,
          aliasName: $_aliasNameGenerator(
              db.exerciseRecords.id, db.videos.exerciseRecord));

  $$VideosTableProcessedTableManager get videosRefs {
    final manager = $$VideosTableTableManager($_db, $_db.videos)
        .filter((f) => f.exerciseRecord.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_videosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExerciseRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseRecordsTable> {
  $$ExerciseRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LocationsTableFilterComposer get location {
    final $$LocationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.location,
        referencedTable: $db.locations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationsTableFilterComposer(
              $db: $db,
              $table: $db.locations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> climbingProblemsRefs(
      Expression<bool> Function($$ClimbingProblemsTableFilterComposer f) f) {
    final $$ClimbingProblemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.climbingProblems,
        getReferencedColumn: (t) => t.exerciseRecord,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClimbingProblemsTableFilterComposer(
              $db: $db,
              $table: $db.climbingProblems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> videosRefs(
      Expression<bool> Function($$VideosTableFilterComposer f) f) {
    final $$VideosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.videos,
        getReferencedColumn: (t) => t.exerciseRecord,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VideosTableFilterComposer(
              $db: $db,
              $table: $db.videos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExerciseRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseRecordsTable> {
  $$ExerciseRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LocationsTableOrderingComposer get location {
    final $$LocationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.location,
        referencedTable: $db.locations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationsTableOrderingComposer(
              $db: $db,
              $table: $db.locations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExerciseRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseRecordsTable> {
  $$ExerciseRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocationsTableAnnotationComposer get location {
    final $$LocationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.location,
        referencedTable: $db.locations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationsTableAnnotationComposer(
              $db: $db,
              $table: $db.locations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> climbingProblemsRefs<T extends Object>(
      Expression<T> Function($$ClimbingProblemsTableAnnotationComposer a) f) {
    final $$ClimbingProblemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.climbingProblems,
        getReferencedColumn: (t) => t.exerciseRecord,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClimbingProblemsTableAnnotationComposer(
              $db: $db,
              $table: $db.climbingProblems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> videosRefs<T extends Object>(
      Expression<T> Function($$VideosTableAnnotationComposer a) f) {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.videos,
        getReferencedColumn: (t) => t.exerciseRecord,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VideosTableAnnotationComposer(
              $db: $db,
              $table: $db.videos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExerciseRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseRecordsTable,
    ExerciseRecord,
    $$ExerciseRecordsTableFilterComposer,
    $$ExerciseRecordsTableOrderingComposer,
    $$ExerciseRecordsTableAnnotationComposer,
    $$ExerciseRecordsTableCreateCompanionBuilder,
    $$ExerciseRecordsTableUpdateCompanionBuilder,
    (ExerciseRecord, $$ExerciseRecordsTableReferences),
    ExerciseRecord,
    PrefetchHooks Function(
        {bool location, bool climbingProblemsRefs, bool videosRefs})> {
  $$ExerciseRecordsTableTableManager(
      _$AppDatabase db, $ExerciseRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> location = const Value.absent(),
          }) =>
              ExerciseRecordsCompanion(
            id: id,
            fileName: fileName,
            isFinished: isFinished,
            createdAt: createdAt,
            updatedAt: updatedAt,
            location: location,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String fileName,
            Value<bool> isFinished = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            required int location,
          }) =>
              ExerciseRecordsCompanion.insert(
            id: id,
            fileName: fileName,
            isFinished: isFinished,
            createdAt: createdAt,
            updatedAt: updatedAt,
            location: location,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExerciseRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {location = false,
              climbingProblemsRefs = false,
              videosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (climbingProblemsRefs) db.climbingProblems,
                if (videosRefs) db.videos
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (location) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.location,
                    referencedTable:
                        $$ExerciseRecordsTableReferences._locationTable(db),
                    referencedColumn:
                        $$ExerciseRecordsTableReferences._locationTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (climbingProblemsRefs)
                    await $_getPrefetchedData<ExerciseRecord,
                            $ExerciseRecordsTable, ClimbingProblem>(
                        currentTable: table,
                        referencedTable: $$ExerciseRecordsTableReferences
                            ._climbingProblemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExerciseRecordsTableReferences(db, table, p0)
                                .climbingProblemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseRecord == item.id),
                        typedResults: items),
                  if (videosRefs)
                    await $_getPrefetchedData<ExerciseRecord,
                            $ExerciseRecordsTable, Video>(
                        currentTable: table,
                        referencedTable: $$ExerciseRecordsTableReferences
                            ._videosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExerciseRecordsTableReferences(db, table, p0)
                                .videosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseRecord == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExerciseRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExerciseRecordsTable,
    ExerciseRecord,
    $$ExerciseRecordsTableFilterComposer,
    $$ExerciseRecordsTableOrderingComposer,
    $$ExerciseRecordsTableAnnotationComposer,
    $$ExerciseRecordsTableCreateCompanionBuilder,
    $$ExerciseRecordsTableUpdateCompanionBuilder,
    (ExerciseRecord, $$ExerciseRecordsTableReferences),
    ExerciseRecord,
    PrefetchHooks Function(
        {bool location, bool climbingProblemsRefs, bool videosRefs})>;
typedef $$DifficultiesTableCreateCompanionBuilder = DifficultiesCompanion
    Function({
  Value<int> id,
  required String name,
  required int colorValue,
  required int score,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required int location,
});
typedef $$DifficultiesTableUpdateCompanionBuilder = DifficultiesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<int> colorValue,
  Value<int> score,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> location,
});

final class $$DifficultiesTableReferences
    extends BaseReferences<_$AppDatabase, $DifficultiesTable, Difficulty> {
  $$DifficultiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocationsTable _locationTable(_$AppDatabase db) =>
      db.locations.createAlias(
          $_aliasNameGenerator(db.difficulties.location, db.locations.id));

  $$LocationsTableProcessedTableManager get location {
    final $_column = $_itemColumn<int>('location')!;

    final manager = $$LocationsTableTableManager($_db, $_db.locations)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_locationTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ClimbingProblemsTable, List<ClimbingProblem>>
      _climbingProblemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.climbingProblems,
              aliasName: $_aliasNameGenerator(
                  db.difficulties.id, db.climbingProblems.difficulty));

  $$ClimbingProblemsTableProcessedTableManager get climbingProblemsRefs {
    final manager =
        $$ClimbingProblemsTableTableManager($_db, $_db.climbingProblems)
            .filter((f) => f.difficulty.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_climbingProblemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DifficultiesTableFilterComposer
    extends Composer<_$AppDatabase, $DifficultiesTable> {
  $$DifficultiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LocationsTableFilterComposer get location {
    final $$LocationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.location,
        referencedTable: $db.locations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationsTableFilterComposer(
              $db: $db,
              $table: $db.locations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> climbingProblemsRefs(
      Expression<bool> Function($$ClimbingProblemsTableFilterComposer f) f) {
    final $$ClimbingProblemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.climbingProblems,
        getReferencedColumn: (t) => t.difficulty,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClimbingProblemsTableFilterComposer(
              $db: $db,
              $table: $db.climbingProblems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DifficultiesTableOrderingComposer
    extends Composer<_$AppDatabase, $DifficultiesTable> {
  $$DifficultiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LocationsTableOrderingComposer get location {
    final $$LocationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.location,
        referencedTable: $db.locations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationsTableOrderingComposer(
              $db: $db,
              $table: $db.locations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DifficultiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DifficultiesTable> {
  $$DifficultiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocationsTableAnnotationComposer get location {
    final $$LocationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.location,
        referencedTable: $db.locations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationsTableAnnotationComposer(
              $db: $db,
              $table: $db.locations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> climbingProblemsRefs<T extends Object>(
      Expression<T> Function($$ClimbingProblemsTableAnnotationComposer a) f) {
    final $$ClimbingProblemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.climbingProblems,
        getReferencedColumn: (t) => t.difficulty,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClimbingProblemsTableAnnotationComposer(
              $db: $db,
              $table: $db.climbingProblems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DifficultiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DifficultiesTable,
    Difficulty,
    $$DifficultiesTableFilterComposer,
    $$DifficultiesTableOrderingComposer,
    $$DifficultiesTableAnnotationComposer,
    $$DifficultiesTableCreateCompanionBuilder,
    $$DifficultiesTableUpdateCompanionBuilder,
    (Difficulty, $$DifficultiesTableReferences),
    Difficulty,
    PrefetchHooks Function({bool location, bool climbingProblemsRefs})> {
  $$DifficultiesTableTableManager(_$AppDatabase db, $DifficultiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DifficultiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DifficultiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DifficultiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> location = const Value.absent(),
          }) =>
              DifficultiesCompanion(
            id: id,
            name: name,
            colorValue: colorValue,
            score: score,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            location: location,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int colorValue,
            required int score,
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            required int location,
          }) =>
              DifficultiesCompanion.insert(
            id: id,
            name: name,
            colorValue: colorValue,
            score: score,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            location: location,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DifficultiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {location = false, climbingProblemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (climbingProblemsRefs) db.climbingProblems
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (location) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.location,
                    referencedTable:
                        $$DifficultiesTableReferences._locationTable(db),
                    referencedColumn:
                        $$DifficultiesTableReferences._locationTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (climbingProblemsRefs)
                    await $_getPrefetchedData<Difficulty, $DifficultiesTable,
                            ClimbingProblem>(
                        currentTable: table,
                        referencedTable: $$DifficultiesTableReferences
                            ._climbingProblemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DifficultiesTableReferences(db, table, p0)
                                .climbingProblemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.difficulty == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DifficultiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DifficultiesTable,
    Difficulty,
    $$DifficultiesTableFilterComposer,
    $$DifficultiesTableOrderingComposer,
    $$DifficultiesTableAnnotationComposer,
    $$DifficultiesTableCreateCompanionBuilder,
    $$DifficultiesTableUpdateCompanionBuilder,
    (Difficulty, $$DifficultiesTableReferences),
    Difficulty,
    PrefetchHooks Function({bool location, bool climbingProblemsRefs})>;
typedef $$ClimbingProblemsTableCreateCompanionBuilder
    = ClimbingProblemsCompanion Function({
  Value<int> id,
  Value<bool> isSuccess,
  Value<bool> isFinished,
  Value<int> trialCount,
  required int exerciseRecord,
  required int difficulty,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ClimbingProblemsTableUpdateCompanionBuilder
    = ClimbingProblemsCompanion Function({
  Value<int> id,
  Value<bool> isSuccess,
  Value<bool> isFinished,
  Value<int> trialCount,
  Value<int> exerciseRecord,
  Value<int> difficulty,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ClimbingProblemsTableReferences extends BaseReferences<
    _$AppDatabase, $ClimbingProblemsTable, ClimbingProblem> {
  $$ClimbingProblemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ExerciseRecordsTable _exerciseRecordTable(_$AppDatabase db) =>
      db.exerciseRecords.createAlias($_aliasNameGenerator(
          db.climbingProblems.exerciseRecord, db.exerciseRecords.id));

  $$ExerciseRecordsTableProcessedTableManager get exerciseRecord {
    final $_column = $_itemColumn<int>('exercise_record')!;

    final manager =
        $$ExerciseRecordsTableTableManager($_db, $_db.exerciseRecords)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseRecordTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $DifficultiesTable _difficultyTable(_$AppDatabase db) =>
      db.difficulties.createAlias($_aliasNameGenerator(
          db.climbingProblems.difficulty, db.difficulties.id));

  $$DifficultiesTableProcessedTableManager get difficulty {
    final $_column = $_itemColumn<int>('difficulty')!;

    final manager = $$DifficultiesTableTableManager($_db, $_db.difficulties)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_difficultyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$VideosTable, List<Video>> _videosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.videos,
          aliasName: $_aliasNameGenerator(
              db.climbingProblems.id, db.videos.climbingProblem));

  $$VideosTableProcessedTableManager get videosRefs {
    final manager = $$VideosTableTableManager($_db, $_db.videos).filter(
        (f) => f.climbingProblem.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_videosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClimbingProblemsTableFilterComposer
    extends Composer<_$AppDatabase, $ClimbingProblemsTable> {
  $$ClimbingProblemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSuccess => $composableBuilder(
      column: $table.isSuccess, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get trialCount => $composableBuilder(
      column: $table.trialCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ExerciseRecordsTableFilterComposer get exerciseRecord {
    final $$ExerciseRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseRecord,
        referencedTable: $db.exerciseRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseRecordsTableFilterComposer(
              $db: $db,
              $table: $db.exerciseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DifficultiesTableFilterComposer get difficulty {
    final $$DifficultiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.difficulty,
        referencedTable: $db.difficulties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DifficultiesTableFilterComposer(
              $db: $db,
              $table: $db.difficulties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> videosRefs(
      Expression<bool> Function($$VideosTableFilterComposer f) f) {
    final $$VideosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.videos,
        getReferencedColumn: (t) => t.climbingProblem,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VideosTableFilterComposer(
              $db: $db,
              $table: $db.videos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClimbingProblemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClimbingProblemsTable> {
  $$ClimbingProblemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSuccess => $composableBuilder(
      column: $table.isSuccess, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get trialCount => $composableBuilder(
      column: $table.trialCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ExerciseRecordsTableOrderingComposer get exerciseRecord {
    final $$ExerciseRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseRecord,
        referencedTable: $db.exerciseRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.exerciseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DifficultiesTableOrderingComposer get difficulty {
    final $$DifficultiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.difficulty,
        referencedTable: $db.difficulties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DifficultiesTableOrderingComposer(
              $db: $db,
              $table: $db.difficulties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClimbingProblemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClimbingProblemsTable> {
  $$ClimbingProblemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isSuccess =>
      $composableBuilder(column: $table.isSuccess, builder: (column) => column);

  GeneratedColumn<bool> get isFinished => $composableBuilder(
      column: $table.isFinished, builder: (column) => column);

  GeneratedColumn<int> get trialCount => $composableBuilder(
      column: $table.trialCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ExerciseRecordsTableAnnotationComposer get exerciseRecord {
    final $$ExerciseRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseRecord,
        referencedTable: $db.exerciseRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.exerciseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DifficultiesTableAnnotationComposer get difficulty {
    final $$DifficultiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.difficulty,
        referencedTable: $db.difficulties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DifficultiesTableAnnotationComposer(
              $db: $db,
              $table: $db.difficulties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> videosRefs<T extends Object>(
      Expression<T> Function($$VideosTableAnnotationComposer a) f) {
    final $$VideosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.videos,
        getReferencedColumn: (t) => t.climbingProblem,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VideosTableAnnotationComposer(
              $db: $db,
              $table: $db.videos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClimbingProblemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClimbingProblemsTable,
    ClimbingProblem,
    $$ClimbingProblemsTableFilterComposer,
    $$ClimbingProblemsTableOrderingComposer,
    $$ClimbingProblemsTableAnnotationComposer,
    $$ClimbingProblemsTableCreateCompanionBuilder,
    $$ClimbingProblemsTableUpdateCompanionBuilder,
    (ClimbingProblem, $$ClimbingProblemsTableReferences),
    ClimbingProblem,
    PrefetchHooks Function(
        {bool exerciseRecord, bool difficulty, bool videosRefs})> {
  $$ClimbingProblemsTableTableManager(
      _$AppDatabase db, $ClimbingProblemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClimbingProblemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClimbingProblemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClimbingProblemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isSuccess = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<int> trialCount = const Value.absent(),
            Value<int> exerciseRecord = const Value.absent(),
            Value<int> difficulty = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ClimbingProblemsCompanion(
            id: id,
            isSuccess: isSuccess,
            isFinished: isFinished,
            trialCount: trialCount,
            exerciseRecord: exerciseRecord,
            difficulty: difficulty,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isSuccess = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<int> trialCount = const Value.absent(),
            required int exerciseRecord,
            required int difficulty,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ClimbingProblemsCompanion.insert(
            id: id,
            isSuccess: isSuccess,
            isFinished: isFinished,
            trialCount: trialCount,
            exerciseRecord: exerciseRecord,
            difficulty: difficulty,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ClimbingProblemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {exerciseRecord = false,
              difficulty = false,
              videosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (videosRefs) db.videos],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (exerciseRecord) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseRecord,
                    referencedTable: $$ClimbingProblemsTableReferences
                        ._exerciseRecordTable(db),
                    referencedColumn: $$ClimbingProblemsTableReferences
                        ._exerciseRecordTable(db)
                        .id,
                  ) as T;
                }
                if (difficulty) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.difficulty,
                    referencedTable:
                        $$ClimbingProblemsTableReferences._difficultyTable(db),
                    referencedColumn: $$ClimbingProblemsTableReferences
                        ._difficultyTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (videosRefs)
                    await $_getPrefetchedData<ClimbingProblem,
                            $ClimbingProblemsTable, Video>(
                        currentTable: table,
                        referencedTable: $$ClimbingProblemsTableReferences
                            ._videosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClimbingProblemsTableReferences(db, table, p0)
                                .videosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.climbingProblem == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClimbingProblemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClimbingProblemsTable,
    ClimbingProblem,
    $$ClimbingProblemsTableFilterComposer,
    $$ClimbingProblemsTableOrderingComposer,
    $$ClimbingProblemsTableAnnotationComposer,
    $$ClimbingProblemsTableCreateCompanionBuilder,
    $$ClimbingProblemsTableUpdateCompanionBuilder,
    (ClimbingProblem, $$ClimbingProblemsTableReferences),
    ClimbingProblem,
    PrefetchHooks Function(
        {bool exerciseRecord, bool difficulty, bool videosRefs})>;
typedef $$VideosTableCreateCompanionBuilder = VideosCompanion Function({
  Value<int> id,
  required String fileName,
  Value<bool> isLike,
  Value<bool> isSuccess,
  required int trialNumber,
  required int climbingProblem,
  required int exerciseRecord,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$VideosTableUpdateCompanionBuilder = VideosCompanion Function({
  Value<int> id,
  Value<String> fileName,
  Value<bool> isLike,
  Value<bool> isSuccess,
  Value<int> trialNumber,
  Value<int> climbingProblem,
  Value<int> exerciseRecord,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$VideosTableReferences
    extends BaseReferences<_$AppDatabase, $VideosTable, Video> {
  $$VideosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClimbingProblemsTable _climbingProblemTable(_$AppDatabase db) =>
      db.climbingProblems.createAlias($_aliasNameGenerator(
          db.videos.climbingProblem, db.climbingProblems.id));

  $$ClimbingProblemsTableProcessedTableManager get climbingProblem {
    final $_column = $_itemColumn<int>('climbing_problem')!;

    final manager =
        $$ClimbingProblemsTableTableManager($_db, $_db.climbingProblems)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_climbingProblemTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ExerciseRecordsTable _exerciseRecordTable(_$AppDatabase db) =>
      db.exerciseRecords.createAlias($_aliasNameGenerator(
          db.videos.exerciseRecord, db.exerciseRecords.id));

  $$ExerciseRecordsTableProcessedTableManager get exerciseRecord {
    final $_column = $_itemColumn<int>('exercise_record')!;

    final manager =
        $$ExerciseRecordsTableTableManager($_db, $_db.exerciseRecords)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseRecordTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$VideosTableFilterComposer
    extends Composer<_$AppDatabase, $VideosTable> {
  $$VideosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLike => $composableBuilder(
      column: $table.isLike, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSuccess => $composableBuilder(
      column: $table.isSuccess, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get trialNumber => $composableBuilder(
      column: $table.trialNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ClimbingProblemsTableFilterComposer get climbingProblem {
    final $$ClimbingProblemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.climbingProblem,
        referencedTable: $db.climbingProblems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClimbingProblemsTableFilterComposer(
              $db: $db,
              $table: $db.climbingProblems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExerciseRecordsTableFilterComposer get exerciseRecord {
    final $$ExerciseRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseRecord,
        referencedTable: $db.exerciseRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseRecordsTableFilterComposer(
              $db: $db,
              $table: $db.exerciseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VideosTableOrderingComposer
    extends Composer<_$AppDatabase, $VideosTable> {
  $$VideosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLike => $composableBuilder(
      column: $table.isLike, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSuccess => $composableBuilder(
      column: $table.isSuccess, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get trialNumber => $composableBuilder(
      column: $table.trialNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ClimbingProblemsTableOrderingComposer get climbingProblem {
    final $$ClimbingProblemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.climbingProblem,
        referencedTable: $db.climbingProblems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClimbingProblemsTableOrderingComposer(
              $db: $db,
              $table: $db.climbingProblems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExerciseRecordsTableOrderingComposer get exerciseRecord {
    final $$ExerciseRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseRecord,
        referencedTable: $db.exerciseRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.exerciseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VideosTableAnnotationComposer
    extends Composer<_$AppDatabase, $VideosTable> {
  $$VideosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<bool> get isLike =>
      $composableBuilder(column: $table.isLike, builder: (column) => column);

  GeneratedColumn<bool> get isSuccess =>
      $composableBuilder(column: $table.isSuccess, builder: (column) => column);

  GeneratedColumn<int> get trialNumber => $composableBuilder(
      column: $table.trialNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ClimbingProblemsTableAnnotationComposer get climbingProblem {
    final $$ClimbingProblemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.climbingProblem,
        referencedTable: $db.climbingProblems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClimbingProblemsTableAnnotationComposer(
              $db: $db,
              $table: $db.climbingProblems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExerciseRecordsTableAnnotationComposer get exerciseRecord {
    final $$ExerciseRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseRecord,
        referencedTable: $db.exerciseRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.exerciseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VideosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VideosTable,
    Video,
    $$VideosTableFilterComposer,
    $$VideosTableOrderingComposer,
    $$VideosTableAnnotationComposer,
    $$VideosTableCreateCompanionBuilder,
    $$VideosTableUpdateCompanionBuilder,
    (Video, $$VideosTableReferences),
    Video,
    PrefetchHooks Function({bool climbingProblem, bool exerciseRecord})> {
  $$VideosTableTableManager(_$AppDatabase db, $VideosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<bool> isLike = const Value.absent(),
            Value<bool> isSuccess = const Value.absent(),
            Value<int> trialNumber = const Value.absent(),
            Value<int> climbingProblem = const Value.absent(),
            Value<int> exerciseRecord = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              VideosCompanion(
            id: id,
            fileName: fileName,
            isLike: isLike,
            isSuccess: isSuccess,
            trialNumber: trialNumber,
            climbingProblem: climbingProblem,
            exerciseRecord: exerciseRecord,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String fileName,
            Value<bool> isLike = const Value.absent(),
            Value<bool> isSuccess = const Value.absent(),
            required int trialNumber,
            required int climbingProblem,
            required int exerciseRecord,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              VideosCompanion.insert(
            id: id,
            fileName: fileName,
            isLike: isLike,
            isSuccess: isSuccess,
            trialNumber: trialNumber,
            climbingProblem: climbingProblem,
            exerciseRecord: exerciseRecord,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$VideosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {climbingProblem = false, exerciseRecord = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (climbingProblem) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.climbingProblem,
                    referencedTable:
                        $$VideosTableReferences._climbingProblemTable(db),
                    referencedColumn:
                        $$VideosTableReferences._climbingProblemTable(db).id,
                  ) as T;
                }
                if (exerciseRecord) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseRecord,
                    referencedTable:
                        $$VideosTableReferences._exerciseRecordTable(db),
                    referencedColumn:
                        $$VideosTableReferences._exerciseRecordTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$VideosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VideosTable,
    Video,
    $$VideosTableFilterComposer,
    $$VideosTableOrderingComposer,
    $$VideosTableAnnotationComposer,
    $$VideosTableCreateCompanionBuilder,
    $$VideosTableUpdateCompanionBuilder,
    (Video, $$VideosTableReferences),
    Video,
    PrefetchHooks Function({bool climbingProblem, bool exerciseRecord})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$ExerciseRecordsTableTableManager get exerciseRecords =>
      $$ExerciseRecordsTableTableManager(_db, _db.exerciseRecords);
  $$DifficultiesTableTableManager get difficulties =>
      $$DifficultiesTableTableManager(_db, _db.difficulties);
  $$ClimbingProblemsTableTableManager get climbingProblems =>
      $$ClimbingProblemsTableTableManager(_db, _db.climbingProblems);
  $$VideosTableTableManager get videos =>
      $$VideosTableTableManager(_db, _db.videos);
}
