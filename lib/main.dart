import 'package:anote_tudo/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Antote Tudo',
      theme: ThemeData(
          fontFamily: "Roboto",
          primaryColor: Colors.grey[600],
          accentColor: Colors.white,
          cursorColor: Colors.grey[900],
          unselectedWidgetColor:
              Colors.grey[900], //cor externa da caixa do check box
          canvasColor: Colors.transparent),
      home: SplashScreen(),
    );
  }
}
