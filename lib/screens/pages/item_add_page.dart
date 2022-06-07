import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/main.dart';

import '../../components/button_with_icon.dart';

import '../../viewmodel.dart';

class ItemAddPage extends StatefulWidget {
  @override
  State<ItemAddPage> createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  File? imageFile;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //TODO バナー広告の初期化
    //https://developers.google.com/admob/flutter/banner#instantiate_ad
    adManager.initBannerAd();
    //TODO バナー広告のロード（AdWidget表示前に呼び出し要）
    //https://developers.google.com/admob/flutter/banner#load_ad
    adManager.loadBannerAd();
  }

  @override
  void dispose() {
    //TODO バナー広告の破棄
    //https://developers.google.com/admob/flutter/banner#display_ad
    adManager.disposeBannerAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "もちもの追加",
            style: TextStyle(color: Colors.black),
          )),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //TODO 広告の表示
              //https://developers.google.com/admob/flutter/banner#display_ad
              Container(
                width: adManager.bannerAd.size.width.toDouble(),
                height: adManager.bannerAd.size.height.toDouble(),
                child: AdWidget(
                  ad: adManager.bannerAd,
                ),
              ),
              SizedBox(height: 20.0),
              //持ち物の画像を表示
              Consumer<ViewModel>(
                builder: (context, vm, child) {
                  final imageFile = vm.imageFile;
                  return CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.black12,
                    backgroundImage: imageFile != null
                        ? Image.file(imageFile, fit: BoxFit.cover).image
                        : AssetImage("assets/images/gray.png"),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () => _pickImageItem(context),
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                child: Text("画像選択"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLength: 10,
                    style: TextStyle(fontSize: 22.0),
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: 'もちもの名',
                      counterText: '10文字まで',
                    ),
                  ),
                ),
              ),
              ButtonWithIcon(
                onPressed: () => _ItemAdd(context),
                icon: Icon(Icons.add_circle_outline),
                label: 'もちものを登録する',
                color: Colors.blue,
              ),
              SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageItem(BuildContext context) async {
    final vm = context.read<ViewModel>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("画像を選択する"),
        actions: <Widget>[
          ButtonWithIcon(
              onPressed: () {
                vm.pickImage(ImageSource.camera);
                //ダイアログ閉じる
                Navigator.pop(context);
              },
              icon: Icon(Icons.photo_camera),
              label: "カメラ",
              color: Colors.orangeAccent),
          SizedBox(height: 28.0),
          ButtonWithIcon(
              onPressed: () {
                vm.pickImage(ImageSource.gallery);
                //ダイアログ閉じる
                Navigator.pop(context);
              },
              icon: Icon(Icons.photo),
              label: "ギャラリー",
              color: Colors.lightBlueAccent),
        ],
      ),
    );
  }

  Future _ItemAdd(BuildContext context) async {
    var itemName = _textEditingController.text;
    // 処理をViewModelへ外注

    final viewModel = context.read<ViewModel>();
    var itemImagePath = viewModel.imageFile != null
        ? viewModel.imageFile!.path
        : File("assets/images/gray.png").path;
    await viewModel.addItem(itemName, itemImagePath);
    Fluttertoast.showToast(
      msg: "登録が完了しました。",
      toastLength: Toast.LENGTH_LONG,
    );
    setState(() {
      _textEditingController.clear();
      viewModel.imageFile = null;
    });
  }
}
