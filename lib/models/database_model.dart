import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database_model.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  IntColumn get type => integer()();
  TextColumn get title => text()();
  DateTimeColumn get dateBought => dateTime()();
  DateTimeColumn get releaseDate => dateTime()();
  TextColumn get currency => text()();
  RealColumn get price => real()();
  RealColumn get shipping => real()();
  BlobColumn get image => blob()();
  TextColumn get link => text()();
  BoolColumn get delivered => boolean()();
  BoolColumn get import => boolean()();
  BoolColumn get paid => boolean()();
  BoolColumn get canceled => boolean()();
}

@DriftDatabase(tables: [Items])
class AmiAmuDatabase extends _$AmiAmuDatabase {
  AmiAmuDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  // READ
  Future<List<Item>> get allItems => select(items).get();

  Future<List<Item>> get allUnCanceledItems =>
      (select(items)..where((tbl) => tbl.canceled.not())).get();

  Future<List<Item>> get allCanceledItems =>
      (select(items)..where((tbl) => tbl.canceled)).get();

  Future<Item> itemByUuid(String uuid) {
    return (select(items)
          ..where((tbl) => tbl.uuid.equals(uuid))
          ..limit(1))
        .getSingle();
  }

  Future<List<Item>> getItemsByDay(DateTime day) {
    return (select(items)..where((tbl) => tbl.releaseDate.equals(day))).get();
  }

  Stream<List<Item>> watchEntries() {
    return select(items).watch();
  }

  // CREATE
  Future<int> addItem(ItemsCompanion entry) {
    return into(items).insert(entry);
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
