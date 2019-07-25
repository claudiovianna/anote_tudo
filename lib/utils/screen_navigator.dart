import 'package:flutter/material.dart';

//Instrução para abrir pages
class ScreenNavigator{

  static void screenNavigatorWithContext(BuildContext contextOrigin, Widget screen){
    final context = contextOrigin;
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return screen;
    }));
  }


}