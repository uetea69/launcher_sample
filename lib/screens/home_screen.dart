import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/screens/pages/item_add_page.dart';
import 'package:untitled1/screens/pages/home_page.dart';
import 'package:untitled1/screens/pages/item_edit_page.dart';

import '../viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex= 0;

  final _pages =[
    HomePage(),
    ItemAddPage(),
    ItemEditPage(),
  ];
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.blue,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label:"ホーム",),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label:"追加"),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                label:"編集"),

          ],
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            setState(() {
              _currentIndex =index;
              if(_currentIndex==ItemAddPage()){
              }else{
                final viewModel = context.read<ViewModel>();
                viewModel.imageFile=null;
              }
            });
          },
        ),
      ),
    );
  }
}