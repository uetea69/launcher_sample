import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../components/items_grid_part.dart';
import '../main.dart';
import '../viewmodel.dart';

class ItemDeleteScreen extends StatefulWidget {
  @override
  State<ItemDeleteScreen> createState() => _ItemDeleteScreenState();
}

class _ItemDeleteScreenState extends State<ItemDeleteScreen> {
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

  @override
  Widget build(BuildContext context) {
    /*
    * ItemEditPageとItemDeleteScreenで同じViewModelを使っているので
    * ItemEditPageを開いた際に取得したViewModel#itemListは有効
    * */
    // final viewModel = context.read<ViewModel>();
    // viewModel.getAllItemsNormal();

    return Consumer<ViewModel>(builder: (BuildContext context, vm, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_sharp)),
          title: Text(
            "選択消去",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await vm.deleteItem();
                  Navigator.pop(context);
                },
                child: Text("完了"))
          ],
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
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
                    itemList: vm.itemList,
                    gridMode: ItemGridOpenMode.ITEM_DELETE),
              ),
            ),
          ],
        ),
      );
    });
  }
}
