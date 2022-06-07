import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Items extends Table {
  IntColumn get itemId => integer().autoIncrement()();

  TextColumn get itemName => text()();

  TextColumn get itemImagePath => text()();

  BoolColumn get isPrepared => boolean().nullable()();

  BoolColumn get isSelected => boolean().nullable()();

  BoolColumn get isChecked => boolean().nullable()();
}

@DriftDatabase(tables: [Items])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  //持ち物の登録Create
  Future<int> addItem(ItemsCompanion item) {
    return into(items).insert(item);
  }

  //持ち物の読み込み
  Future<List<Item>> get allItems => select(items).get();
  //Read(選択前の持ち物)
  Future<List<Item>> get allItemsSelected => (select(items)
    ..where((table) =>
    table.isSelected.equals(false))).get();
  //Read(用意済み持ち物除外)
  Future<List<Item>> get allItemsExcludedPrepared => (select(items)
        ..where((table) =>
            table.isSelected.equals(true) & table.isPrepared.equals(false)))
      .get();

  //Read(用意済み持ち物抽出)
  Future<List<Item>> get allItemsIncludedPrepared => (select(items)
        ..where((table) =>
            table.isSelected.equals(true) & table.isPrepared.equals(true)))
      .get();

  //持ち物の更新
  Future updateItem(Item item) => update(items).replace(item);

  //delete
  Future deleteItem(Item item) =>
      (delete(items)..where((table) => table.itemId.equals(item.itemId))).go();

  Future deleteAllItems() {
    return delete(items).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'database.db'));
    return NativeDatabase(file);
  });
}
