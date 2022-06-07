import 'dart:io';

//import 'package:firebase_admob/firebase_admob.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  //BannerAd? bannerAd;
  late BannerAd bannerAd;

  Future<void> initAdmob() {
    print("initAdmob");
    //async無い場合はreturn文必要
    return MobileAds.instance.initialize();
    //asyncをつけるとこれでもイケる
    //MobileAds.instance.initialize();
  }

  void initBannerAd() {
    print("initBannerAd");
    bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print("Ad Loaded: $ad")
      ),
    );
  }

  void loadBannerAd() {
    print("loadBannerAd");
    bannerAd.load();
  }

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3364901739591913~8717473906";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3364901739591913~8497433316";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    /*
    * TODO 本番の広告ID
    *  Android: ca-app-pub-3364901739591913/3273575530
    *  iOS: ca-app-pub-3364901739591913/6992779952
    * */

    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  void disposeBannerAd() {
    bannerAd.dispose();
  }
}
