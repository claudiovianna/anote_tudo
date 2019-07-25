import 'dart:convert';
import 'dart:io';

import 'package:anote_tudo/utils/screen_navigator.dart';
import 'package:anote_tudo/widgets/drawer_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'anote_screen.dart';


class ComprasScreen extends StatefulWidget {
  @override
  _ComprasScreenState createState() => _ComprasScreenState();
}

class _ComprasScreenState extends State<ComprasScreen> {
  final _toDoController = TextEditingController();

  List _toDoList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  @override
  void initState() {
    super.initState();

    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((a, b) {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: TextStyle(color: Colors.blue)
        title: Text(
          "Lista de Compras",
          style: TextStyle(color: Colors.white, fontSize: 23.0),
        ),
        //Cor app bar
        //backgroundColor: Color.fromARGB(100, 52, 175, 35),
        backgroundColor: Colors.green[500],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.mode_edit,
              color: Colors.white,
            ),
            onPressed: () {
              openAnoteScreen();
            },
            padding: EdgeInsets.only(right: 20),
          )
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
                    controller: _toDoController,
                    decoration: InputDecoration(
                      labelText: "Suas Compras",
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: 20.0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.green[600],
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
              backgroundColor:  Colors.green[700],
              //color: Colors.pink,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
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
        // Altera a cor do fundo para exclusão
        color: Colors.green[400],
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child:
              Icon(Icons.delete, size: 40.0, color: Colors.red // cor da Lixeira
                  ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        // cor da caixa checkBox
        activeColor: Colors.green[700],
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          backgroundColor: Colors.green[700], // Cor interior CicleAvatar
          foregroundColor: Colors.white, // cor do icone
          child: Icon(_toDoList[index]["ok"]
              ? Icons.add_shopping_cart
              : Icons.shopping_cart),
        ),
        onChanged: (c) {
          setState(() {
            _toDoList[index]["ok"] = c;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          _saveData();

          //          final snack = SnackBar(
          SnackBar(
            backgroundColor: Colors.black38, // cor da Barra de tarefa
            content: Text(
              "Item: \"${_lastRemoved["title"]}\" removida!",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ), // cor do texto
            action: SnackBarAction(
                label: "Desfazer",
                textColor: Colors.red, // Cor do Label (rótulo) desfazer
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos, _lastRemoved);
                    _saveData();
                  });
                }),
            duration: Duration(seconds: 4),
          );
          //Scaffold.of(context).showSnackBar(snack);
          Scaffold.of(context).reassemble();
        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/tarefanew.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
  void openAnoteScreen(){
    ScreenNavigator.screenNavigatorWithContext(context, AnoteScreen());
  }
}
