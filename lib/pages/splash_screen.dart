import 'dart:async';
import 'package:anote_tudo/pages/anote_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AnoteScreen(),
          )
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: _caderno(),
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 220, 20, 50),
              ),
              //_anote_tudo(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12, 40, 12, 40),
                child: Text(
                  "Versão 4.3.8",
                  //x.x.X = numero de correções
                  //x.X.x = melhorias que sofreu o aplicativo
                  //X.x.x = funções importantes incorporadas desde o lançamentoc
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color(0xff808080),
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Image _caderno() {
    //return Image.asset("assets/images/caderno_lapis.png", fit: BoxFit.fill);
    return Image.asset("assets/images/splash.png", fit: BoxFit.cover);
  }

}
