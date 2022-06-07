import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'db/database.dart';
import 'main.dart';

class ViewModel extends ChangeNotifier {
  List<Item> itemExcludedPreparedList = [];
  List<Item> itemIncludedPreparedList = [];
  List<Item> ItemSelectedList = [];
  List<Item> itemList = [];
  var myColor = Colors.white;
  File? imageFile;

  // bool isProcessing = false;

  Future<void> updatePreparedItem({required Item item}) async {
    if (item.isPrepared == false) {
      var updateItem = Item(
        itemId: item.itemId,
        itemImagePath: item.itemImagePath,
        itemName: item.itemName,
        isPrepared: true,
        isSelected: true,
        isChecked: false,
      );
      await database.updateItem(updateItem);
      getAllItems();
      getAllItemsNormal();
    } else {
      var updateItem = Item(
        itemId: item.itemId,
        itemImagePath: item.itemImagePath,
        itemName: item.itemName,
        isPrepared: false,
        isSelected: true,
        isChecked: false,
      );
      await database.updateItem(updateItem);
      getAllItems();
      getAllItemsNormal();
    }
  }

  Future<void> updateItem({required Item item, required bool isCheck}) async {
    if (isCheck == false) {
      var updateItem = Item(
        itemId: item.itemId,
        itemImagePath: item.itemImagePath,
        itemName: item.itemName,
        isPrepared: false,
        isSelected: false,
        isChecked: false,
      );
      await database.updateItem(updateItem);
      getAllItems();
      getAllItemsNormal();
    } else {
      var updateItem = Item(
        itemId: item.itemId,
        itemImagePath: item.itemImagePath,
        itemName: item.itemName,
        isPrepared: false,
        isSelected: false,
        isChecked: true,
      );
      await database.updateItem(updateItem);
      getAllItems();
      getAllItemsNormal();
    }
  }

  Future<void> updateSelectItem(
      {required Item item, required bool isSelect}) async {
    if (isSelect == true) {
      var updateItem = Item(
        itemId: item.itemId,
        itemImagePath: item.itemImagePath,
        itemName: item.itemName,
        isPrepared: false,
        isSelected: true,
        isChecked: false,
      );
      await database.updateItem(updateItem);
    } else {
      var updateItem = Item(
        itemId: item.itemId,
        itemImagePath: item.itemImagePath,
        itemName: item.itemName,
        isPrepared: false,
        isSelected: false,
        isChecked: false,
      );
      await database.updateItem(updateItem);
    }
  }

  Future<void> getAllItems() async {
    itemExcludedPreparedList = await database.allItemsIncludedPrepared;
    itemIncludedPreparedList = await database.allItemsExcludedPrepared;
    ItemSelectedList = await database.allItemsSelected;
    notifyListeners();
  }

  Future<void> deleteAllItem() async {
    await database.deleteAllItems();
    getAllItemsNormal();
    getAllItems();
  }

  Future<void> getAllItemsNormal() async {
    itemList = await database.allItems;
    notifyListeners();
  }

  Future<void> deleteItem() async {
    itemList.forEach((item) {
      if (item.isChecked == true) {
        database.deleteItem(item);
      }
      getAllItems();
      getAllItemsNormal();
    });
    return;
  }

  Future<void> resetItem() async {
    itemList = await database.allItems;
    itemList.forEach((item) async {
      if (item.isPrepared == true) {
        var updateItem = Item(
          itemId: item.itemId,
          itemImagePath: item.itemImagePath,
          itemName: item.itemName,
          isPrepared: false,
          isSelected: true,
          isChecked: false,
        );
        await database.updateItem(updateItem);
      }
      getAllItems();
      getAllItemsNormal();
    });
    return;
  }

  Future<void> resetClearItem() async {
    itemList = await database.allItems;
    itemList.forEach((item) async {
      if (item.isSelected == true) {
        var updateItem = Item(
          itemId: item.itemId,
          itemImagePath: item.itemImagePath,
          itemName: item.itemName,
          isPrepared: false,
          isSelected: false,
          isChecked: false,
        );
        await database.updateItem(updateItem);
      }
      getAllItems();
      getAllItemsNormal();
    });

    return;
  }

  Future<void> pickImage(ImageSource source) async {
    imageFile = null;
    notifyListeners();

    final imagePicker = ImagePicker();
    final XFile? _image = await imagePicker.pickImage(
      source: source,
      imageQuality: 15,
    );
    if (_image == null) {
      return;
    }

    imageFile = File(_image.path);

    final appDirectory = await getApplicationDocumentsDirectory();
    final String inAppPath = appDirectory.path;
    final itemImageName = basename(_image.path);
    final File _savedImage = await imageFile!.copy('$inAppPath/$itemImageName');

    imageFile = _savedImage;

    notifyListeners();
  }

  Future<void> addItem(String itemName, String itemImagePath) async {
    final item = ItemsCompanion(
      itemName: Value(itemName.toString()),
      itemImagePath: Value(itemImagePath),
      isPrepared: Value(false),
      isSelected: Value(false),
      isChecked: Value(false),
    );
    await database.addItem(item);
    getAllItems();
    getAllItemsNormal();
  }

  Future<void> updateEditItem(
      item, String itemName, String itemImagePath) async {
    var updateItem = Item(
        itemId: item.itemId,
        itemName: itemName,
        itemImagePath: itemImagePath,
        isPrepared: false,
        isSelected: false,
        isChecked: false);
    await database.updateItem(updateItem);
    getAllItems();
    getAllItemsNormal();
  }

  Future<void> deleteEditItem(item) async {
    var deleteItem = Item(
        itemId: item.itemId,
        itemName: item.itemName,
        itemImagePath: item.itemImagePath,
        isPrepared: false,
        isSelected: false,
        isChecked: false);
    await database.deleteItem(deleteItem);
    getAllItems();
    getAllItemsNormal();
  }
}
