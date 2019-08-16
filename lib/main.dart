import 'dart:io';

import 'package:anote_tudo/pages/splash_screen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';


const String appIdAdMobAndroid = "ca-app-pub-4994376613873903~6675930317";
const String appIdAdMobIos = "ca-app-pub-4994376613873903~5362848641";


const String adUnitIdAndroidBlocoAnuncio = "ca-app-pub-7751208694726247/9742929435";
const String adUnitIdIosBlocoAnuncio = "ca-app-pub-4994376613873903/7574079016";

//***>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//  keywords: <String>['flutterio', 'beautiful apps'],
//  contentUrl: 'https://flutter.io',
//  //birthday: DateTime.now(),
//  childDirected: false,
//  //designedForFamilies: false,
//  //gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
//  testDevices: <String>[], // Android emulators are considered test devices
//);

//
//BannerAd myBanner = BannerAd(
//  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//   //https://developers.google.com/admob/android/test-ads
//   //https://developers.google.com/admob/ios/test-ads
//  adUnitId: BannerAd.testAdUnitId,
//  size: AdSize.banner,
//  targetingInfo: targetingInfo,
//  listener: (MobileAdEvent event) {
//    print("BannerAd event is $event");
//  },
//);

//InterstitialAd myInterstitial = InterstitialAd(
//  // Replace the testAdUnitId with an ad unit id from the AdMob dash
//  // https://developers.google.com/admob/android/test-ads
//  // https://developers.google.com/admob/ios/test-ads
//  adUnitId: InterstitialAd.testAdUnitId,
//  targetingInfo: targetingInfo,
//  listener: (MobileAdEvent event) {
//    print("InterstitialAd event is $event");
//  },
//);

//***>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static  FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver (analytics : analytics);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  BannerAd _bannerAd;
  bool _adShown;
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[BannerAd.testAdUnitId],
  );
  BannerAd createBannerAd(){
    //*** Bloco de anuncios reais descomentar antes do lançamento
    var adUnitIdBlocoAnuncio;
    if(Platform.isAndroid){
      adUnitIdBlocoAnuncio = adUnitIdAndroidBlocoAnuncio;
    }else if(Platform.isIOS){
      adUnitIdBlocoAnuncio = adUnitIdIosBlocoAnuncio;
    }
    return BannerAd(
      //*** Bloco de anuncios reais descomentar antes do lançamento
      //adUnitId: adUnitIdBlocoAnuncio,
        adUnitId: BannerAd.testAdUnitId,

        targetingInfo: targetingInfo,
        size: AdSize.smartBanner,
        listener:
            (MobileAdEvent event){
          if(event == MobileAdEvent.loaded){
            _adShown = true;
            setState(() {

            });
          }else if(event ==MobileAdEvent.failedToLoad){
            _adShown = false;
            setState(() {

            });
          }
        }
    );
  }
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Antote Tudo',
      theme: ThemeData(
          fontFamily: "Roboto",
          primaryColor: Colors.grey[600],
          accentColor: Colors.white,
          cursorColor: Colors.grey[900],
          unselectedWidgetColor:
              Colors.grey[900], //cor externa da caixa do check box
          canvasColor: Colors.transparent
      ),
        home:  SplashScreen(),
//***>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        builder: (BuildContext context, Widget child) {

          createBannerAd()
            ..load()
            ..show(anchorOffset: 0.0,
                anchorType: AnchorType.bottom);

          //myBanner
            //..load()
            //..show(
             // anchorOffset: 0.0,
              //anchorType: AnchorType.bottom,
           // );
          return Padding(
            child: child,
            padding: EdgeInsets.only(
              bottom: 50,
            ),
          );
        }
      //***>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    );
  }
}

