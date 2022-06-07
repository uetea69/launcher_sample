// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Item extends DataClass implements Insertable<Item> {
  final int itemId;
  final String itemName;
  final String itemImagePath;
  final bool? isPrepared;
  final bool? isSelected;
  final bool? isChecked;
  Item(
      {required this.itemId,
      required this.itemName,
      required this.itemImagePath,
      this.isPrepared,
      this.isSelected,
      this.isChecked});
  factory Item.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Item(
      itemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_id'])!,
      itemName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_name'])!,
      itemImagePath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_image_path'])!,
      isPrepared: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_prepared']),
      isSelected: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_selected']),
      isChecked: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_checked']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<int>(itemId);
    map['item_name'] = Variable<String>(itemName);
    map['item_image_path'] = Variable<String>(itemImagePath);
    if (!nullToAbsent || isPrepared != null) {
      map['is_prepared'] = Variable<bool?>(isPrepared);
    }
    if (!nullToAbsent || isSelected != null) {
      map['is_selected'] = Variable<bool?>(isSelected);
    }
    if (!nullToAbsent || isChecked != null) {
      map['is_checked'] = Variable<bool?>(isChecked);
    }
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      itemId: Value(itemId),
      itemName: Value(itemName),
      itemImagePath: Value(itemImagePath),
      isPrepared: isPrepared == null && nullToAbsent
          ? const Value.absent()
          : Value(isPrepared),
      isSelected: isSelected == null && nullToAbsent
          ? const Value.absent()
          : Value(isSelected),
      isChecked: isChecked == null && nullToAbsent
          ? const Value.absent()
          : Value(isChecked),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      itemId: serializer.fromJson<int>(json['itemId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      itemImagePath: serializer.fromJson<String>(json['itemImagePath']),
      isPrepared: serializer.fromJson<bool?>(json['isPrepared']),
      isSelected: serializer.fromJson<bool?>(json['isSelected']),
      isChecked: serializer.fromJson<bool?>(json['isChecked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<int>(itemId),
      'itemName': serializer.toJson<String>(itemName),
      'itemImagePath': serializer.toJson<String>(itemImagePath),
      'isPrepared': serializer.toJson<bool?>(isPrepared),
      'isSelected': serializer.toJson<bool?>(isSelected),
      'isChecked': serializer.toJson<bool?>(isChecked),
    };
  }

  Item copyWith(
          {int? itemId,
          String? itemName,
          String? itemImagePath,
          bool? isPrepared,
          bool? isSelected,
          bool? isChecked}) =>
      Item(
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        itemImagePath: itemImagePath ?? this.itemImagePath,
        isPrepared: isPrepared ?? this.isPrepared,
        isSelected: isSelected ?? this.isSelected,
        isChecked: isChecked ?? this.isChecked,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('itemImagePath: $itemImagePath, ')
          ..write('isPrepared: $isPrepared, ')
          ..write('isSelected: $isSelected, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      itemId, itemName, itemImagePath, isPrepared, isSelected, isChecked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.itemId == this.itemId &&
          other.itemName == this.itemName &&
          other.itemImagePath == this.itemImagePath &&
          other.isPrepared == this.isPrepared &&
          other.isSelected == this.isSelected &&
          other.isChecked == this.isChecked);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> itemId;
  final Value<String> itemName;
  final Value<String> itemImagePath;
  final Value<bool?> isPrepared;
  final Value<bool?> isSelected;
  final Value<bool?> isChecked;
  const ItemsCompanion({
    this.itemId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.itemImagePath = const Value.absent(),
    this.isPrepared = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.isChecked = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.itemId = const Value.absent(),
    required String itemName,
    required String itemImagePath,
    this.isPrepared = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.isChecked = const Value.absent(),
  })  : itemName = Value(itemName),
        itemImagePath = Value(itemImagePath);
  static Insertable<Item> custom({
    Expression<int>? itemId,
    Expression<String>? itemName,
    Expression<String>? itemImagePath,
    Expression<bool?>? isPrepared,
    Expression<bool?>? isSelected,
    Expression<bool?>? isChecked,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (itemName != null) 'item_name': itemName,
      if (itemImagePath != null) 'item_image_path': itemImagePath,
      if (isPrepared != null) 'is_prepared': isPrepared,
      if (isSelected != null) 'is_selected': isSelected,
      if (isChecked != null) 'is_checked': isChecked,
    });
  }

  ItemsCompanion copyWith(
      {Value<int>? itemId,
      Value<String>? itemName,
      Value<String>? itemImagePath,
      Value<bool?>? isPrepared,
      Value<bool?>? isSelected,
      Value<bool?>? isChecked}) {
    return ItemsCompanion(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemImagePath: itemImagePath ?? this.itemImagePath,
      isPrepared: isPrepared ?? this.isPrepared,
      isSelected: isSelected ?? this.isSelected,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (itemImagePath.present) {
      map['item_image_path'] = Variable<String>(itemImagePath.value);
    }
    if (isPrepared.present) {
      map['is_prepared'] = Variable<bool?>(isPrepared.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool?>(isSelected.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool?>(isChecked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('itemImagePath: $itemImagePath, ')
          ..write('isPrepared: $isPrepared, ')
          ..write('isSelected: $isSelected, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int?> itemId = GeneratedColumn<int?>(
      'item_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _itemNameMeta = const VerificationMeta('itemName');
  @override
  late final GeneratedColumn<String?> itemName = GeneratedColumn<String?>(
      'item_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _itemImagePathMeta =
      const VerificationMeta('itemImagePath');
  @override
  late final GeneratedColumn<String?> itemImagePath = GeneratedColumn<String?>(
      'item_image_path', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isPreparedMeta = const VerificationMeta('isPrepared');
  @override
  late final GeneratedColumn<bool?> isPrepared = GeneratedColumn<bool?>(
      'is_prepared', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_prepared IN (0, 1))');
  final VerificationMeta _isSelectedMeta = const VerificationMeta('isSelected');
  @override
  late final GeneratedColumn<bool?> isSelected = GeneratedColumn<bool?>(
      'is_selected', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_selected IN (0, 1))');
  final VerificationMeta _isCheckedMeta = const VerificationMeta('isChecked');
  @override
  late final GeneratedColumn<bool?> isChecked = GeneratedColumn<bool?>(
      'is_checked', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_checked IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [itemId, itemName, itemImagePath, isPrepared, isSelected, isChecked];
  @override
  String get aliasedName => _alias ?? 'items';
  @override
  String get actualTableName => 'items';
  @override
  VerificationContext validateIntegrity(Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    }
    if (data.containsKey('item_name')) {
      context.handle(_itemNameMeta,
          itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta));
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('item_image_path')) {
      context.handle(
          _itemImagePathMeta,
          itemImagePath.isAcceptableOrUnknown(
              data['item_image_path']!, _itemImagePathMeta));
    } else if (isInserting) {
      context.missing(_itemImagePathMeta);
    }
    if (data.containsKey('is_prepared')) {
      context.handle(
          _isPreparedMeta,
          isPrepared.isAcceptableOrUnknown(
              data['is_prepared']!, _isPreparedMeta));
    }
    if (data.containsKey('is_selected')) {
      context.handle(
          _isSelectedMeta,
          isSelected.isAcceptableOrUnknown(
              data['is_selected']!, _isSelectedMeta));
    }
    if (data.containsKey('is_checked')) {
      context.handle(_isCheckedMeta,
          isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Item.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ItemsTable items = $ItemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [items];
}
