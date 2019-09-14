import 'package:flutter/material.dart';

class PerguntasRespostas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Perguntas e Respostas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Icon(Icons.lightbulb_outline, ),Text(""),
            Padding(
              padding: EdgeInsets.only(top: 10),
              ),
            Container(
              child: ListTile(
                title: Text(
                  "Preciso de internet para utilizar esse app?",
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("Não, o Anote Tudo funciona sem internet.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
              ),
            ),
            Container(
              child: ListTile(
                title: Text(
                  "Como faço para excluir uma tarefa?",
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text("Arraste o item da esquerda para direita.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: ListTile(
                title: Text(
                  "Como faço para excluir uma compra?",
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text("Arraste o item da esquerda para direita.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: ListTile(
                title: Text(
                  "Como fazer a reorganização dos itens selecionados e não selecionados?",
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text("Deslize o dedo para baixo sobre a tela a partir do primeiro item.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: ListTile(
                title: Text(
                  "Quando tiver atualização do app, eu vou receber?",
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text("Sim, se seu app foi adquirido nas lojas Apple Store ou Google Play.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: ListTile(
                title: Text(
                  "O que acontece se eu excluir o Anote Tudo de meu celular?",
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text("Todos os seus dados armazenados serão perdidos e não poderão ser recuperados.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: ListTile(
                title: Text(
                  "Como eu posso me tornar VIP?",
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text("acesse o menu e clique em Tornar se VIP.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: ListTile(
                title: Text(
                  "Como se comunicar com a equipe de desenvolvimento?",
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text("Envie um email para mobile@cast4.com.br", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
