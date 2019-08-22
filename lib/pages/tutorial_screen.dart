import 'package:anote_tudo/utils/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'anote_screen.dart';
import 'compras_screen.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  List<Slide> slides = List();

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
          title: "SEJA VIP",
          styleTitle: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto"),
          heightImage: 100.0,
          widthImage: 100.0,
          marginDescription: EdgeInsets.only(left: 10, top: 40, right: 10),
          styleDescription: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: "Roboto"),
          description: "+ Itens ilimitados\n"
              "+ Atualização do app\n"
              "+ Recuperação de item excluído\n"
              "+ Contato com os desenvolvedores\n"
              "+ Reogarnização automática dos itens\n\n"
              "Quer se tornar um usuário VIP?\nNo final deste tutorial clique na imagem.",
          pathImage: "assets/images/este_seja_bem_vindo.png",
          backgroundColor: Colors.green[300]),
    );
    slides.add(
      Slide(
          title: "LISTA DE TAREFAS",
          styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
          heightImage: 100.0,
          widthImage: 100.0,
          marginDescription: EdgeInsets.only(left: 10, top: 40, right: 10),
          styleDescription: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: "Roboto"),
          description:
              '''Anote suas tarefas, seus filmes prediletos, recados, telefones, pagamentos, horários de remédios, disciplinas, reuniões, etc.\n\nVocê não vai mais precisar de papel nem de caneta, apenas do Anote Tudo!''',
          pathImage: "assets/images/este_seja_bem_vindo.png",
          backgroundColor: Colors.green[300]),
    );
    slides.add(
      Slide(
          title: "LISTA DE COMPRAS",
          styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
          heightImage: 100.0,
          widthImage: 100.0,
          marginDescription: EdgeInsets.only(left: 10, top: 40, right: 10),
          styleDescription: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: "Roboto"),
          description:
              '''Anote sua lista de mercado, materiais escolares, materiais de construção, remédios, ração do seu pet, etc.\n\n Você não vai mais esquecer aquele item importante de suas compras!''',
          pathImage: "assets/images/este_seja_bem_vindo.png",
          backgroundColor: Colors.green[300]),
    );

    slides.add(
      Slide(
        title: "QUERO SER VIP",
        styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto"),
        heightImage: 100.0,
        widthImage: 100.0,
        marginDescription: EdgeInsets.only(left: 10, top: 40, right: 10),
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.normal,
            fontFamily: "Roboto"),
        onCenterItemPress: () {
          ScreenNavigator.screenNavigatorWithContext(context, ComprasScreen());
        },
        pathImage: "assets/images/este_seja_bem_vindo.png",
        description: "Click na imagem!\n\n\n\Ou\n\n\nclique em CONTINUAR FREE",
        backgroundColor: Colors.green[300],
      ),
    );
  }

  void onDonePress() {
    ScreenNavigator.screenNavigatorWithContext(context, AnoteScreen());
  }

  void onSkipPress() {
    ScreenNavigator.screenNavigatorWithContext(context, AnoteScreen());
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}
