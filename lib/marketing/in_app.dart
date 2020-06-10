import 'dart:async';
import 'dart:io';
import 'package:anote_tudo/pages/anote_screen.dart';
import 'package:anote_tudo/utils/alert_r_flutter.dart';
import 'package:anote_tudo/utils/screen_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_inapp_purchase/modules.dart';
import 'package:in_app_purchase/billing_client_wrappers.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InApp extends StatefulWidget {
  @override
  _InAppState createState() => _InAppState();
}

class _InAppState extends State<InApp> {

  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  final List<String> _productLists = Platform.isAndroid ? ['rc.premium.0001'] : ['RC.PREMIUM.0001'];
  String _platformVersion = "Unknown";
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];
  bool _available = false;




  @override
  void initState() {
    super.initState();
    endConnection();
    initPlatformState();
  }


  ///método necessário para o Android entender que a conexão foi rompida
  Future<void> endConnection() async {
    print("Executou endConnection()");
    await FlutterInappPurchase.instance.endConnection;
    _purchaseUpdatedSubscription.cancel();
    _purchaseUpdatedSubscription = null;
    _purchaseErrorSubscription.cancel();
    _purchaseErrorSubscription = null;
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    ///verificando se o usuário já é VIP
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("PREMIUM_VIP") != null && prefs.getBool("PREMIUM_VIP")){
      ///alerta de sucesso
      final alert = AlertRFlutter.alertOneButton(context, "PARABÉNS", "Você já é VIP", "OK");
      alert.alertSuccessWithOneButtonWithoutAction().show();
    }


    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
      _platformVersion = platformVersion;
    } on PlatformException {
      platformVersion = "A recuperação da Plataforma $_platformVersion falhou!";
    }

    ///preparação para conexão com as lojas
    var result = await FlutterInappPurchase.instance.initConnection;
    print("Preparação para conexão com as lojas. Result: $result");

    ///"true" para o iOS e "billing client ready" para o Android
    if(result.toLowerCase() == "true" || result.toLowerCase() == "billing client ready"){
      _available = true;
      print("Viabilidade de compras: $_available");
      await _getProduct();
    }

    ///caso o widget seja removido durante as atividades assíncronas,
    ///é melhor descartar as respostas e não setar na tela com o setState
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) async{
      print("Compra efetuada com sucesso do produto: $productItem");
      /// flag no sharedPreference
      if(productItem.productId == "RC.PREMIUM.0001" || productItem.productId == "rc.premium.0001"){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("PREMIUM_VIP", true);






//        ///confirmação de compra para Android
//        if(Platform.isAndroid){
//
//
//        }

        ///alerta de sucesso
        final alert = AlertRFlutter.alertOneButton(context, "PARABÉNS", "Sua compra foi realizada com sucesso", "OK");
        alert.alertSuccessWithOneButtonWithoutAction().show();
      }else{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("PREMIUM_VIP", false);
      }

    });

    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print("Error em Compra do produto: $purchaseError");
      ///alerta de erro
      final alert = AlertRFlutter.alertOneButton(context, "OPS!", "Aconteceu algo que impediu sua compra", "OK");
      alert.alertErrorWithOneButton().show();
    });

  }

  void _requestPurchase(IAPItem item){
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future<Null> _getProduct() async {
    List<IAPItem> itens = await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in itens){
      print("Item para compra: ${item.toString()}");
      //print("Item para compra: ${item.title}");
      this._items.add(item);
    }

//    setState(() {
//      this._items = itens;
//      this._purchases = [];
//    });
  }

//  Future<Null> _getPurchases() async {
//    List<PurchasedItem> itens = await FlutterInappPurchase.instance.getAvailablePurchases();
//
//    for (var item in itens){
//      print("Compra viável: ${item.toString()}");
//      this._purchases.add(item);
//    }
//
//    setState(() {
//      this._items = [];
//      this._purchases = itens;
//    });
//  }

  ///recupera compras anteriores
  Future<Null> _getPurchaseHistory() async {
    List<PurchasedItem> items = await FlutterInappPurchase.instance.getPurchaseHistory();
    print("Lista de itens recuperados em Compras Anterioes está vazia? ${items.isEmpty}");

    if(items.isNotEmpty){
      print("controle 1");
      for (var item in items){
        print("controle 2");
        //print("Item já comprado: ${item.toString()}");
        if(Platform.isIOS){
          print("controle 3");
          print("Item já comprado: ${item.productId} em  ${item.originalTransactionDateIOS}");
          if (item.productId == "RC.PREMIUM.0001"){
            print("controle 4");
            /// flag no sharedPreference
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("PREMIUM_VIP", true);

            ///alerta de sucesso
            final alert = AlertRFlutter.alertOneButton(context, "SUCESSO", "Suas compras realizadas anteriormente foram recuperadas", "OK");
            alert.alertSuccessWithOneButtonWithoutAction().show();
          }
        }else if(Platform.isAndroid){
          print("controle 5");
          print("Item já comprado: ${item.productId}");
          if (item.productId == "rc.premium.0001"){
            print("controle 6");
            /// flag no sharedPreference
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("PREMIUM_VIP", true);

            ///alerta de sucesso
            final alert = AlertRFlutter.alertOneButton(context, "SUCESSO", "Suas compras realizadas anteriormente foram recuperadas", "OK");
            alert.alertSuccessWithOneButtonWithoutAction().show();
          }
        }
        this._purchases.add(item);
      }

      setState(() {
        print("controle 7");
        this._items = [];
        this._purchases = items;
      });
    }else{
      print("controle 8");
      ///alerta de fracasso
      print("Entrou em alerta de fracasso na recuperação de itens já comprados");
      final alert = AlertRFlutter(context, "OPS!", "Não existem compras realizadas anteriormente", "OK");
      alert.alertWarningWithOneButton().show();
    }

  }

  void openOkButton() {
    ScreenNavigator.screenNavigatorWithContext(context, InApp());
  }
  void openOkButtonToDrawerList() {
    ScreenNavigator.screenNavigatorWithContext(context, AnoteScreen());
  }


  List<Widget> _renderInApps() {
    //_getProduct();
    List<Widget> widgets = this
        ._items
        .map((item) => Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 0.0),
              child: Text(
                //item.toString(),
                item.title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                  //color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 0.0),
              child: Text(
                //item.toString(),
                item.description,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[600],
                  //color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(bottom:0.0),
              child: Text(
                //item.toString(),
                item.localizedPrice,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[600],
                  //color: Colors.white,
                ),
              ),
            ),
          Container(
            height: 60.0,
            margin: EdgeInsets.all(7.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(16)
              ),
              color: Colors.orange[400],
              onPressed: () {
                print("O botão de compra foi precionado!!!");
                this._requestPurchase(item);
              },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment(0.0, 0.0),
                  child: Text('COMPRAR',
              style: TextStyle(
                  fontSize: 16.0,
              ),
              ),
                ),
             ),
          ),
          ],
        ),
      ),
    ))
        .toList();
    return widgets;
  }

//  List<Widget> _renderPurchases() {
//    List<Widget> widgets = this
//        ._purchases
//        .map((item) => Container(
//      margin: EdgeInsets.symmetric(vertical: 10.0),
//      child: Container(
//        child: Column(
//          children: <Widget>[
//            Container(
//              margin: EdgeInsets.only(bottom: 5.0),
//              child: Text(
//                //item.toString(),
//                item.productId,
//                style: TextStyle(
//                  fontSize: 18.0,
//                  color: Colors.black,
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    ))
//        .toList();
//    return widgets;
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _available ? "Listas Ilimitadas" : "Não Disponível",
          style: TextStyle(color: Colors.white, fontSize: 23.0),
        ),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                //width: buttonWidth,
                  height: 60.0,
                  //margin: EdgeInsets.all(7.0),
                  margin: EdgeInsets.fromLTRB(7.0, 90, 7.0, 20),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius:  BorderRadius.circular(16)
                    ),
                    color: Colors.green[400],
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      print(
                          "Botão de recuperar histórico de compras pressionado");
                      this._getPurchaseHistory();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: Alignment(0.0, 0.0),
                      child: Text(
                        'RECUPERAR COMPRAS',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  )
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text("ITENS PARA COMPRA",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
            ],
          ),
          Column(
            children: this._renderInApps(),
          )
        ],
      )
    );
  }

}
