import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/components/items_grid_part.dart';
import 'package:untitled1/main.dart';

import '../../viewmodel.dart';
enum Reset { Clear, All }
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getAllItems();
  }

  Future<void> _getAllItems() async {
    final viewModel = context.read<ViewModel>();
    await viewModel.getAllItems();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    viewModel.getAllItems();
    return Consumer<ViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
            appBar: AppBar(
              title: Center(
                  child:
                      Text("もちものチェック", style: TextStyle(color: Colors.black))),
              backgroundColor: Colors.white,
              actions: [
                Center(
                  child: PopupMenuButton<Reset>(
                    child: Text(
                      "リセット",
                      style:TextStyle(color:Colors.black),
                    ),
                    onSelected: (Reset selectedReset) async {
                      if (selectedReset == Reset.Clear) {
                        viewModel.resetClearItem();
                      } else {
                        viewModel.resetItem();
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<Reset>>[
                      PopupMenuItem<Reset>(
                        value: Reset.All,
                        child: Text('用意する前の状態にする'),
                      ),
                      PopupMenuItem<Reset>(
                        value: Reset.Clear,
                        child: Text('選択前の状態にする'),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                ElevatedButton(
                    onPressed: () => openChoiceItemDialog(context),
                    child: Text("もちもの選択",style: TextStyle(fontSize: 16),)),
                Text("用意済みの持ち物",style: TextStyle(fontSize: 20),),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                    ),
                    child: ItemsGridPart(
                        itemList: vm.itemExcludedPreparedList,
                        gridMode: ItemGridOpenMode.ITEM_CHECK),
                  ),
                ),
                Text("まだ用意してない持ち物",style: TextStyle(fontSize: 20),),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                    ),
                    child: ItemsGridPart(
                        itemList: vm.itemIncludedPreparedList,
                        gridMode: ItemGridOpenMode.ITEM_CHECK),
                  ),
                ),
              ],
            ));
      },
    );
  }

  openChoiceItemDialog(BuildContext context) async {
    final vm = context.read<ViewModel>();
    await vm.getAllItemsNormal();
    showDialog(
        context: context,
        builder: (_) =>
            Consumer<ViewModel>(builder: (BuildContext context, vm, child) {
              return Dialog(
                child: SizedBox(
                  height: screenHeight / 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("もちもの選択"),
                      ),
                      Expanded(
                        child: ItemsGridPart(
                            itemList: vm.ItemSelectedList,
                            gridMode: ItemGridOpenMode.ITEM_SELECT,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _getAllItems();
                          Navigator.pop(context);
                        },
                        child: Text("完了"),
                      ),
                    ],
                  ),
                ),
              );
            },),);
  }
}
