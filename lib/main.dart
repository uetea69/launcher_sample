import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:untitled1/models/ad_manager.dart';
import 'package:untitled1/viewmodel.dart';
import 'db/database.dart';
import 'screens/home_screen.dart';

late MyDatabase database;
AdManager adManager = AdManager();

double screenWidth = 0.0;
double screenHeight = 0.0;

void main() async {
  //広告の初期化
  //https://developers.google.com/admob/flutter/quick-start#initialize_the_mobile_ads_sdk
  WidgetsFlutterBinding.ensureInitialized();
  await adManager.initAdmob();

  database = MyDatabase();

  runApp(
    ChangeNotifierProvider<ViewModel>(
      create: (context) => ViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    if (data.size.shortestSide < 550) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }else{ SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);}
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: "バッグの中身",
      theme: ThemeData(fontFamily: "kiwi"),
      home: HomeScreen(),
    );
  }
}
