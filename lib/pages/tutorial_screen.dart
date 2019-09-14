import 'package:anote_tudo/utils/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'anote_screen.dart';


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
          title: "FUNCIONALIDADES",
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
              "Quer se tornar um usuário VIP?\nEntre no aplicativo, acesse\no menu e clique em Tornar se VIP",
          pathImage: "assets/images/funcionalidades.png",
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
              '''Anote suas tarefas, seus filmes prediletos, recados, telefones, pagamentos, horários de remédios, disciplinas, reuniões, etc...\n\nVocê não vai mais precisar de papel e de caneta, apenas do Anote Tudo!''',
          pathImage: "assets/images/tarefas.png",
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
              '''Anote sua lista de mercado, materiais escolares, materiais de construção, remédios, ração do seu pet, etc...\n\n Você não vai mais esquecer aquele item importante de suas compras!''',
          pathImage: "assets/images/compras.png",
          backgroundColor: Colors.green[300]),
    );

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
        onCenterItemPress: () {},

        pathImage: "assets/images/vip.png",
        description: "BENEFÍCIOS\n\n"
            "+ Funcionalidades liberadas para sempre\n"
            "+ Itens ilimitados em suas listas\n\n"
            "Imagine você ter todas as funcionalidades\ndisponíveis para sempre,"
            "\ninclusive novas funcionalidades\nem atualizações futuras do aplicativo.\n\n"
            "ISSO É SUPER PRODUTIVO!",
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
