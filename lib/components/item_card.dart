import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/database.dart';
import '../screens/item_edit_screen.dart';
import '../viewmodel.dart';
import 'items_grid_part.dart';

class ItemCard extends StatefulWidget {
  final ItemGridOpenMode gridMode;

  final Item item;

  const ItemCard({
    required this.item,
    required this.gridMode,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  var isCheck = false;

  bool isSelected = false;

  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return Card(
        child: Stack(
      children: [
        ListTile(
          title: TitleText(),
          subtitle: SubTitleText(),
          onTap: () => TapListTile(),
        ),
        (widget.gridMode == ItemGridOpenMode.ITEM_DELETE)
            ? Positioned(
                top: 0.0,
                right: 0.0,
                child: Checkbox(
                  value: isCheck,
                  onChanged: (value) {
                    setState(() {
                      isCheck = value!;
                      viewModel.updateItem(item: widget.item, isCheck: isCheck);
                    });
                  },
                ),
              )
            : (widget.gridMode == ItemGridOpenMode.ITEM_SELECT)
                ? Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Checkbox(
                      value: isCheck,
                      onChanged: (value) {
                        setState(() {
                          isCheck = value!;
                          viewModel.updateSelectItem(
                              item: widget.item, isSelect: isCheck);
                        });
                      },
                    ),
                  )
                : Container(),
      ],
    ));
  }

  editSelectedItem(BuildContext context, Item item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemEditScreen(item: item),
      ),
    );
  }

  TitleText() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    if (data.size.shortestSide < 550) {
      if (widget.gridMode == ItemGridOpenMode.ITEM_SELECT) {
        return Text(
          "${widget.item.itemName}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 7),
        );
      } else if (widget.gridMode == ItemGridOpenMode.ITEM_CHECK) {
        return Text(
          "${widget.item.itemName}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.5),
        );
      } else {
        return Text(
          "${widget.item.itemName}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        );
      }
    } else {
      if (widget.gridMode == ItemGridOpenMode.ITEM_SELECT) {
        return Text(
          "${widget.item.itemName}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 21),
        );
      } else if (widget.gridMode == ItemGridOpenMode.ITEM_CHECK) {
        return Text(
          "${widget.item.itemName}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        );
      } else {
        return Text(
          "${widget.item.itemName}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        );
      }
    }
  }

  SubTitleText() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    if (data.size.shortestSide < 550) {
      if (widget.gridMode == ItemGridOpenMode.ITEM_SELECT) {
        return CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black12,
          backgroundImage:
              Image.file(File(widget.item.itemImagePath), fit: BoxFit.cover)
                  .image,
        );
      } else {
        if (widget.gridMode == ItemGridOpenMode.ITEM_CHECK) {
          return CircleAvatar(
            radius: 28,
            backgroundColor: Colors.black12,
            backgroundImage:
                Image.file(File(widget.item.itemImagePath), fit: BoxFit.cover)
                    .image,
          );
        } else {
          return CircleAvatar(
            radius: 35,
            backgroundColor: Colors.black12,
            backgroundImage:
                Image.file(File(widget.item.itemImagePath), fit: BoxFit.cover)
                    .image,
          );
        }
      }
    } else {
      if (widget.gridMode == ItemGridOpenMode.ITEM_SELECT) {
        return CircleAvatar(
          radius: 52,
          backgroundColor: Colors.black12,
          backgroundImage:
              Image.file(File(widget.item.itemImagePath), fit: BoxFit.cover)
                  .image,
        );
      } else {
        if (widget.gridMode == ItemGridOpenMode.ITEM_CHECK) {
          return CircleAvatar(
            radius: 42,
            backgroundColor: Colors.black12,
            backgroundImage:
                Image.file(File(widget.item.itemImagePath), fit: BoxFit.cover)
                    .image,
          );
        } else {
          return CircleAvatar(
            radius: 50,
            backgroundColor: Colors.black12,
            backgroundImage:
                Image.file(File(widget.item.itemImagePath), fit: BoxFit.cover)
                    .image,
          );
        }
      }
    }
  }

  TapListTile() async {
    final viewModel = context.read<ViewModel>();
    switch (widget.gridMode) {
      case ItemGridOpenMode.ITEM_EDIT:
        {
          editSelectedItem(context, widget.item);
          break;
        }
      case ItemGridOpenMode.ITEM_CHECK:
        {
          await viewModel.updatePreparedItem(item: widget.item);

          break;
        }
      case ItemGridOpenMode.ITEM_SELECT:
        {
          break;
        }
      case ItemGridOpenMode.ITEM_DELETE:
        {
          break;
        }
    }
  }
}
