import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/button_with_icon.dart';
import '../db/database.dart';
import '../main.dart';
import '../viewmodel.dart';

class ItemEditScreen extends StatefulWidget {
  final Item item;

  const ItemEditScreen({
    required this.item,
  });

  @override
  State<ItemEditScreen> createState() => _ItemEditScreenState();
}

class _ItemEditScreenState extends State<ItemEditScreen> {
  File? imageFile;
  TextEditingController _textEditingController = TextEditingController();
  Item? _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
    _textEditingController =
        TextEditingController(text: _item != null ? "${_item!.itemName}" : "");
    adManager.initBannerAd();
    adManager.loadBannerAd();
  }

  @override
  void dispose() {
    adManager.disposeBannerAd();
    super.dispose();
  }

  Widget build(BuildContext context) {
    _item = widget.item;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                "☓",
                style: TextStyle(color: Colors.black, fontSize: 25),
              )),
          title: Text(
            "    もちものの編集",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Consumer<ViewModel>(
          builder: (context, vm, child) {
            final imageFile = vm.imageFile;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: adManager.bannerAd.size.width.toDouble(),
                    height: adManager.bannerAd.size.height.toDouble(),
                    child: AdWidget(
                      ad: adManager.bannerAd,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  //持ち物の画像を表示
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.black12,
                    backgroundImage: imageFile != null
                        ? Image.file(imageFile, fit: BoxFit.cover).image
                        : Image.file(File(_item!.itemImagePath),
                                fit: BoxFit.cover)
                            .image,
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImageItem(context),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent),
                    child: Text("画像選択"),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    maxLength: 10,
                    style: TextStyle(fontSize: 14.0),
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: 'もちもの名',
                      counterText: '10文字まで',
                    ),
                  ),
                  SizedBox(height: 32),
                  ButtonWithIcon(
                      onPressed: () => _ItemUpdate(context, _item!),
                      icon: Icon(Icons.add_circle_outline),
                      label: 'もちものを変更する',
                      color: Colors.blue),
                  SizedBox(height: 32),
                  ButtonWithIcon(
                      onPressed: () => _ItemDelete(context, _item!),
                      icon: Icon(Icons.delete),
                      label: 'もちものを削除する',
                      color: Colors.black54),
                ],
              ),
            );
          },
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

  _ItemUpdate(BuildContext context, _item) async {
    var itemName = _textEditingController.text;
    var item = _item;
    final viewModel = context.read<ViewModel>();
    String itemImagePath = viewModel.imageFile != null
        ? viewModel.imageFile!.path
        : _item!.itemImagePath;
    await viewModel.updateEditItem(item, itemName, itemImagePath);
    viewModel.imageFile = null;
    Navigator.pop(context, true);
  }

  _ItemDelete(BuildContext context, _item) async {
    var item = _item;
    final viewModel = context.read<ViewModel>();
    await viewModel.deleteEditItem(item);
    viewModel.imageFile = null;
    Navigator.pop(context, true);
  }
}
