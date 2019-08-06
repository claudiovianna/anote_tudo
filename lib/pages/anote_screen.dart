import 'dart:convert';
import 'dart:io';
import 'package:anote_tudo/utils/screen_navigator.dart';
import 'package:anote_tudo/widgets/drawer_list.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'compras_screen.dart';
import 'perguntas_respostas.dart';

const appIdAdMobAndroid = "ca-app-pub-4994376613873903~6675930317";
const appIdAdMobIos = "ca-app-pub-4994376613873903~5362848641";

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['bloco', 'palavras', 'listas', 'compras'],
  contentUrl: 'https://flutter.io',
  //birthday: DateTime.now(),
  childDirected: false,
  //designedForFamilies: false,
  //gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  //*** Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: BannerAd.testAdUnitId,
  //Android
  //adUnitId: "ca-app-pub-7751208694726247/9742929435",
  //iOS
  //adUnitId: "ca-app-pub-4994376613873903/7574079016",
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd evento $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  //*** Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: InterstitialAd.testAdUnitId,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd evento anote $event");
  },
);

class AnoteScreen extends StatefulWidget {
  AnoteScreen({Key key, this.title, this.analytics, this.observer})
      : super(key: key);
  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _AnoteScreenState createState() => _AnoteScreenState(analytics, observer);
}

class _AnoteScreenState extends State<AnoteScreen> {
  _AnoteScreenState(this.analytics, this.observer);
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

  final _toDoController = TextEditingController();

  List _toDoList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  @override
  void initState() {
    var appIdAdMob;
    if(Platform.isAndroid){
      appIdAdMob = appIdAdMobAndroid;
    }else if(Platform.isIOS){
      appIdAdMob = appIdAdMobIos;
    }
    FirebaseAdMob.instance.initialize(appId: appIdAdMob);

    myBanner..load();
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
    myBanner..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
    return Scaffold(
      //Cor backGround
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        //title: TextStyle(color: Colors.white)
        title: Text(
          "Tarefas", //Cor do título - Lista Geral
          style: TextStyle(color: Colors.white, fontSize: 23.0),
        ),
        //Cor do appBar
        backgroundColor: Colors.green[400],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
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
                    controller: _toDoController,
                    decoration: InputDecoration(
                      labelText: "Suas tarefas:",
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
              backgroundColor: Colors.grey[800],
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: buildItem),
            ),
          ),
          //banner(context, child)
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
        title: Text(_toDoList[index]["title"]),
        activeColor: Colors.green[700],
        // cor da caixa do checkBox
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          backgroundColor: Colors.green[700], // Cor interior CicleAvatar
          foregroundColor: Colors.white, // cor do icone
          child:
              Icon(_toDoList[index]["ok"] ? Icons.thumb_up : Icons.mode_edit),
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

          final snack = SnackBar(
            //SnackBar(
            backgroundColor: Colors.green[400],
            // cor da Barra de tarefa
            content: Text(
              "Item: \"${_lastRemoved["title"]}\" removido!",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            // cor do texto
            action: SnackBarAction(
                label: "Desfazer",
                textColor: Colors.white,
                // Cor do Label (rótulo) desfazer
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos, _lastRemoved);
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

  Future<File> _getFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return File("${directory.path}/tarefa.json");
    } catch (e) {
      print("Erro no _getFile: $e");
      return null;
    }
  }

  Future<File> _saveData() async {
    try {
      String data = json.encode(_toDoList);
      final file = await _getFile();
      return file.writeAsString(data);
    } catch (e) {
      print("Erro no _saveData: $e");
      return null;
    }
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      print("Erro no _readData: $e");
      return null;
    }
  }

  //Navegação entre paginas
  void openPerguntasRespostas() {
    ScreenNavigator.screenNavigatorWithContext(context, PerguntasRespostas());
  }

  void openComprasScreen() {
    ScreenNavigator.screenNavigatorWithContext(context, ComprasScreen());
  }

  @override
  void dispose() {
    myBanner?.dispose();
    super.dispose();
  }
}
