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
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Icon(Icons.lightbulb_outline, ),Text("Ola"),
            Padding(
              padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 0.0),
              ),

            ListTile(
              title: Text(
                "Preciso de internet para utilizar esse app?",
                style: TextStyle(
                    color: Colors.grey[900], fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text("Não, o Anote Tudo funciona sem internet.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
            ),
            ListTile(
              title: Text(
                "Como faço para excluir uma tarefa?",
                style: TextStyle(
                    color: Colors.grey[900], fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text("Arraste o item da esquerda para direita.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
            ),
            ListTile(
              title: Text(
                "Como atualizar a lista?",
                style: TextStyle(
                    color: Colors.grey[900], fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text("Deslize o dedo para baixo sobre a tela a partir do primeiro item.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
            ),

            ListTile(
              title: Text(
                "Quando tiver atualização do app eu vou receber?",
                style: TextStyle(
                    color: Colors.grey[900], fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text("Sim, se seu app foi adquirido no Google Play.", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
            ),
            ListTile(
              title: Text(
                "Se eu excluir o Anote Tudo de meu celular?",
                style: TextStyle(
                    color: Colors.grey[900], fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text("Todos os seus dados armazenados serão perdidos e não poderá recupera-los", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),
            ),
            ListTile(
              title: Text(
                "Contato com o desenvolvedor?",
                style: TextStyle(
                    color: Colors.grey[900], fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text("IOs: claudiolavianna@gmail.com\nAndroid: robocast1331@gmail.com", style: TextStyle(color: Colors.grey[700], fontSize: 14.0),),

            ),
          ],
        ),
      ),
    );
  }
}
