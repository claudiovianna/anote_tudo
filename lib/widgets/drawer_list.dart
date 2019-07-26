import 'package:anote_tudo/pages/compras_screen.dart';
import 'package:anote_tudo/pages/anote_screen.dart';
import 'package:anote_tudo/pages/perguntas_respostas.dart';
import 'package:anote_tudo/pages/termo_responsabilidade.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //        margin: EdgeInsets.only(bottom: 8.0),
//        padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
        //width: 300,
        width: 300,
        color: Colors.grey[350],
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 16.0, 0.0),
                  height: 170,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 16.0,
                        left: 90.0,
                        right: 10.0,
                        child: Text(
                          "Anote\nTudo!",
                          style: TextStyle(
                              fontSize: 44.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  color: Colors.grey[200],
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 8.0, 10.0, 0.0),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AnoteScreen()));
              },
              title: Text(
                "Anotações",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Suas tarefas gerais",
              ),
              leading: Icon(
                Icons.mode_edit,
                size: 40.0,
                color: Colors.grey[800],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ComprasScreen()));
              },
              title: Text(
                "Compras",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Sua lista de compras",
              ),
              leading: Icon(
                Icons.add_shopping_cart,
                size: 40.0,
                color: Colors.grey[800],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TermoUso()));
              },
              title: Text(
                "Termo de Uso e Responsabilidade",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Informações Legais do app",
              ),
              leading: Icon(
                Icons.error,
                size: 40.0,
                color: Colors.grey[800],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PerguntasRespostas()));
              },
              title: Text(
                "Perguntas e Respostas",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Informações de funcionamento do app",
              ),
              leading: Icon(
                Icons.help_outline,
                size: 40.0,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
