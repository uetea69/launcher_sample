import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/screens/item_delete_screen.dart';

import '../../components/items_grid_part.dart';
import '../../main.dart';
import '../../viewmodel.dart';

enum Clear { Select, All }

class ItemEditPage extends StatefulWidget {
  @override
  State<ItemEditPage> createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  @override
  @override
  void initState() {
    super.initState();
    adManager.initBannerAd();
    adManager.loadBannerAd();
  }

  @override
  void dispose() {
    adManager.disposeBannerAd();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    viewModel.getAllItemsNormal();
    return Consumer<ViewModel>(builder: (BuildContext context, vm, child) {
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "編集画面",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          actions: [
            PopupMenuButton<Clear>(
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onSelected: (Clear selectedClear) async {
                if (selectedClear == Clear.Select) {
                  startItemDeleteScreen(context);
                } else {
                  await viewModel.deleteAllItem();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Clear>>[
                PopupMenuItem<Clear>(
                  value: Clear.Select,
                  child: Text('選択消去'),
                ),
                PopupMenuItem<Clear>(
                  value: Clear.All,
                  child: Text('全消去'),
                ),
              ],
            )
          ],
        ),
        body: Column(
          children: [Container(
                    width: adManager.bannerAd.size.width.toDouble(),
                    height: adManager.bannerAd.size.height.toDouble(),
                    child: AdWidget(
                      ad: adManager.bannerAd,
                    )),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),
                child: ItemsGridPart(
                    itemList: vm.itemList, gridMode: ItemGridOpenMode.ITEM_EDIT),
              ),
            ),
          ],
        ),
      );
    });
  }

  startItemDeleteScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ItemDeleteScreen()),
    );
  }
}
