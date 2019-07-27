import 'package:anote_tudo/pages/compras_screen.dart';
import 'package:anote_tudo/pages/anote_screen.dart';
import 'package:anote_tudo/pages/perguntas_respostas.dart';
import 'package:anote_tudo/pages/termos_de_uso.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 300,
        color: Colors.grey[350],
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 16.0, 0.0),
                  height: 150,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child:

                        Column(
                          children: <Widget>[
                            Container(child: _blocoNotas(),
                                height: 80,
                                width: 180,
                            ),
                          ],
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AnoteScreen()));
              },
              title: Text(
                "Tarefas",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Sua lista de tarefas", style: TextStyle(
                fontSize: 14,
              ),
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ComprasScreen()));
              },
              title: Text(
                "Compras",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Sua lista de compras",style: TextStyle(
                fontSize: 14,
              ),
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TermosDeUso()));
              },
              title: Text(
                "Termo de Uso",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Informações Legais do app",style: TextStyle(
                fontSize: 14,
              ),
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
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Informações de funcionamento do app",style: TextStyle(
                fontSize: 14,
              ),
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
//  Image _blocoNotas() {
//    return Image.asset("assets/images/bloco_de_notas.png", fit: BoxFit.none);
//  }
  Image _blocoNotas() {
    return Image.asset("assets/images/logo.png", fit: BoxFit.fill);
  }
}
