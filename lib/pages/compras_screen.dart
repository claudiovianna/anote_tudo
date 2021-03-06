import 'dart:convert';
import 'dart:io';
import 'package:anote_tudo/marketing/in_app.dart';
import 'package:anote_tudo/utils/alert_r_flutter.dart';
import 'package:anote_tudo/utils/screen_navigator.dart';
import 'package:anote_tudo/widgets/drawer_list.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'anote_screen.dart';

class ComprasScreen extends StatefulWidget {
  ComprasScreen({Key key, this.title, this.analytics, this.observer})
      : super(key: key);
  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _ComprasScreenState createState() => _ComprasScreenState(analytics, observer);
}

class _ComprasScreenState extends State<ComprasScreen> {
  _ComprasScreenState(this.analytics, this.observer);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  final _toDoControllerCompras = TextEditingController();

  List _toDoListCompras = [];
  Map<String, dynamic> _lastRemovedCompras;
  int _lastRemovedPosCompras;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoListCompras = json.decode(data);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoControllerCompras.text;
      //validadndo o campo vazio
      if (_toDoControllerCompras.text != "") {
        _toDoControllerCompras.text = "";
        newToDo["ok"] = false;
        _productControl(newToDo);
      }
    });
  }

  ///controla recursos comprados
  _productControl(Map<String, dynamic> newToDo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("PREMIUM_VIP") == null || prefs.getBool("PREMIUM_VIP") == false) {
      //contando itens da lista
      var qtdItens = _toDoListCompras.length + 1;
      print("Quantidade de itens: $qtdItens");
      if (qtdItens <= 10) {
        _toDoListCompras.add(newToDo);
        _saveData();
      } else {
        print("<<<<<<<<<<<<<<<<<<<  VIRE VIP  >>>>>>>>>>>>>>>>>>");
        final alert = AlertRFlutter.alertTwoButtons(
            context,
            "SEJA VIP",
            "Essa versão é limitada a 10 itens por lista. Para que você utilize todas as vantagens e sobretudo itens ilimitados nas listas torne-se VIP!",
            "EU QUERO",
            "NÃO QUERO");
        alert
            .alertWarningWithTwoButtons(openCancelButton, openVipButton)
            .show();
      }
    } else if (prefs.getBool("PREMIUM_VIP") == true) {
      _toDoListCompras.add(newToDo);
      _saveData();
    }
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoListCompras.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });
      _saveData();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //Cor backGround
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        //title: TextStyle(color: Colors.white)
        title: Text(
          "Compras", //Cor do título - Lista Geral
          style: TextStyle(color: Colors.white, fontSize: 23.0),
        ),
        //Cor do appBar
        backgroundColor: Colors.green[400],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.mode_edit,
              color: Colors.white,
            ),
            onPressed: () {
              openComprasScreen();
            },
            padding: EdgeInsets.only(right: 20),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 2.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _toDoControllerCompras,
                    decoration: InputDecoration(
                      labelText: "Suas compras:",
                      labelStyle:
                          //Cor do texto  - Nova Tarefa
                          TextStyle(color: Colors.black, fontSize: 20),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2),
                ),
                RaisedButton(
                  //Cor do bottão adicionar
                  color: Colors.green[400],
                  //Cor do text do botão - Adicionar
                  child: Text("Adicionar"),
                  textColor: Colors.white,
                  onPressed: _addToDo,
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              // Altera a cor do Refresh
              backgroundColor: Colors.green[700],
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0, bottom: 30),
                  itemCount: _toDoListCompras.length,
                  itemBuilder: buildItem),
            ),
          )
        ],
      ),
      drawer: DrawerList(),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        // Altera a cor do backGround para exclusão
        color: Colors.red[600],
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete,
              size: 40.0, color: Colors.white // cor da Lixeira
              ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoListCompras[index]["title"]),
        activeColor: Colors.green[700],
        // cor da caixa do checkBox
        value: _toDoListCompras[index]["ok"],
        secondary: CircleAvatar(
          backgroundColor: Colors.green[700], // Cor interior CicleAvatar
          foregroundColor: Colors.white, // cor do icone
          child: Icon(_toDoListCompras[index]["ok"]
              ? Icons.shopping_cart
              : Icons.add_shopping_cart),
        ),
        onChanged: (compras) {
          setState(() {
            _toDoListCompras[index]["ok"] = compras;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemovedCompras = Map.from(_toDoListCompras[index]);
          _lastRemovedPosCompras = index;
          _toDoListCompras.removeAt(index);
          _saveData();

          final snack = SnackBar(
            //SnackBar(
            backgroundColor: Colors.green[400],
            // cor da Barra de tarefa
            content: Text(
              "Item: \"${_lastRemovedCompras["title"]}\" removido!",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            // cor do texto
            action: SnackBarAction(
                label: "Desfazer",
                textColor: Colors.white,
                // Cor do Label (rótulo) desfazer
                onPressed: () {
                  setState(() {
                    _toDoListCompras.insert(
                        _lastRemovedPosCompras, _lastRemovedCompras);
                    _saveData();
                  });
                }),
            duration: Duration(seconds: 6),
          );
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }

  Future<File> _getFileCompras() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/compra.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoListCompras);
    final file = await _getFileCompras();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFileCompras();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  void openComprasScreen() {
    ScreenNavigator.screenNavigatorWithContext(context, AnoteScreen());
  }

  void openVipButton() {
    ///TESTE DE ITENS ILIMITADOS
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setInt("RC.PREMIUM.0001", 1);
    ScreenNavigator.screenNavigatorWithContext(context, InApp());
  }

  void openCancelButton() {
    ScreenNavigator.screenNavigatorWithContext(context, ComprasScreen());
  }
}
