import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Transactions extends Table {
  TextColumn get id => text()();
  RealColumn get amount => real()();
  TextColumn get category => text()(); // Simplified for now, could be FK
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text()();
  // Store attachments as JSON string or delimiter-separated path
  TextColumn get attachments => text().withDefault(const Constant('[]'))(); 
  
  // Sync fields
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get editedLocally => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastModified => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  
  // Sync fields
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get editedLocally => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastModified => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Transactions, Categories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Migration from version 1 to 2: Add sync fields to both tables
        await m.addColumn(transactions, transactions.isSynced);
        await m.addColumn(transactions, transactions.editedLocally);
        await m.addColumn(transactions, transactions.lastModified);
        await m.addColumn(categories, categories.isSynced);
        await m.addColumn(categories, categories.editedLocally);
        await m.addColumn(categories, categories.lastModified);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
