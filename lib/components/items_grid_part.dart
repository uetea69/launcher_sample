import 'package:flutter/material.dart';

import '../db/database.dart';
import 'item_card.dart';

enum ItemGridOpenMode { ITEM_DELETE, ITEM_EDIT, ITEM_CHECK, ITEM_SELECT }

class ItemsGridPart extends StatelessWidget {
  final List<Item> itemList;
  final ItemGridOpenMode gridMode;

  const ItemsGridPart({
    Key? key,
    required this.itemList,
    required this.gridMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (itemList.isNotEmpty)
        ? Scrollbar(
      thickness: 8,
      hoverThickness: 16,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: CrossAxisCount(context),
        children: List.generate(
          itemList.length,
          ((index) {
            return ItemCard(
              item: itemList[index],
              gridMode: gridMode,
            );
          }),
        ),
      ),
    )
        : Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "もちものはありません。",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  CrossAxisCount(BuildContext context) {
    var isPortrait = MediaQuery
        .of(context)
        .orientation == Orientation.portrait;
    if (gridMode == ItemGridOpenMode.ITEM_CHECK) {
      if (isPortrait) {
        return 4;
      } else {
        return 7;
      }
    }
    else {
      if (isPortrait) {
        return 3;
      } else {
        return 5;
      }
    }
  }
}