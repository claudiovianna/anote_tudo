import 'dart:async';

import 'package:anote_tudo/pages/anote_screen.dart';
import 'package:anote_tudo/pages/tutorial_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //verificando se é a primeira execução do App
  Future _checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AnoteScreen()));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => TutorialScreen()));
    }
  }

  Future _createFlagPremium() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getBool("PREMIUM_VIP") == null){
      print("Flag PremiumVip: ${prefs.getBool("PREMIUM_VIP")}");
      await prefs.setBool("PREMIUM_VIP", false);
      print("Flag PremiumVip: ${prefs.getBool("PREMIUM_VIP")}");
    }
    print("Flag PremiumVip gravada: ${prefs.getBool("PREMIUM_VIP")}");

  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      _checkFirstSeen();
      _createFlagPremium();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          SizedBox.expand(child: _caderno()),
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
                  "Versão 1.0.1", //x.x.X = numero de correções
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
    return Image.asset(
      "assets/images/splash_nativo.png",
    );
  }
}
