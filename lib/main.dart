import 'package:anote_tudo/pages/splash_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static  FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver (analytics : analytics);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


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
    );
  }

}

