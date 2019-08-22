import 'package:flutter/material.dart';

//Instrução para abrir pages
class ScreenNavigator{

  static void screenNavigatorWithContext(BuildContext contextOrigin, Widget screen){
    final context = contextOrigin;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return screen;
    }));
//    Navigator.push(context, MaterialPageRoute(builder: (context){
//      return screen;
//    }));
  }

  static void screenNavigatorPopWithContext(BuildContext contextOrigin, Widget screen) {
    final context = contextOrigin;
    Navigator.pop(context, MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }


}