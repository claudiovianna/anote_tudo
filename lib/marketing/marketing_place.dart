import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


class MarketingPlace extends StatefulWidget {
  @override
  _MarketingPlaceState createState() => _MarketingPlaceState();
}

class _MarketingPlaceState extends State<MarketingPlace> {

  //loja viável
  bool _available = false;
  //instância da InAppPurchase
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;
  //produtos para venda
  List<ProductDetails> _products = [];
  //Compras passadas
  List<PurchaseDetails> _purchases = [];
  //atualização de compras
  StreamSubscription _subscription;


  @override
  void initState() {
    print("Entrou no initState");
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _initialize() async {
    print("Entrou no initialize");
    //checando a viabilidade da loja
    _available = await _iap.isAvailable();
    print("Valor de available: $_available");

    if(_available){
      await _getProducts();
      await _getPastPurchases();

      //verificando e entregrando o produto de acordo com a lógica de negócio
      _verifyPurchase();

    }

    //listen para novas compras
    _subscription = _iap.purchaseUpdatedStream.listen((data) => setState(() {
      print("Nova compra realizada");
      _purchases.addAll(data);
      //verificando e entregrando o produto de acordo com a lógica de negócio
      _verifyPurchase();
    }));
  }

  //recupera todos os produtos viáveis na loja
  Future<List<ProductDetails>> _getProducts() async {
    print("Entrou no getProducts");
    final idsIos = ['RC.PREMIUM.0001'];
    final idsAndroid = ['rc.premium.0001'];
    Set<String> ids;
    if(Platform.isIOS){
      print("Entrou na plataforma ios no getProducts");
      ids = idsIos.toSet();
    }else if(Platform.isAndroid){
      print("Entrou na plataforma android no getProducts");
      ids = idsAndroid.toSet();
    }

    ProductDetailsResponse response = await _iap.queryProductDetails(ids);
    _products = response.productDetails;
    print("Products em getProducts: ${_products.first.id}");


//    setState(() {
//      print("Entrou no setState do getProducts");
//      _products = response.productDetails;
//    });
    return _products;
  }

  //recupera compras já efetuadas
  Future<void> _getPastPurchases() async {
    print("Entrou no getPastPurchases");
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();
    print("Valor de response no getPastPurchase: ${response.pastPurchases.toString()}");
    for(PurchaseDetails purchase in response.pastPurchases){
      if(Platform.isIOS){
        print("Entrou na plataforma ios no getPastPurchases");
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
    }
    _purchases = response.pastPurchases;

//    setState(() {
//      print("Entrou no setState do getPastPurchases");
//      _purchases = response.pastPurchases;
//    });
  }


  //confirma a compra de um  produto específico
  PurchaseDetails _hasPurchased(String productID) {
    print("Entrou no hasPurchased");
    return _purchases.firstWhere((purchase) => purchase.productID == productID, orElse: () => null);
  }




  void _verifyPurchase() {
    print("Entrou no verifyPurcgase");
    final idsIos = 'RC.PREMIUM.0001';
    final idsAndroid = 'rc.premium.0001';
    String productID;
    if(Platform.isIOS){
      productID = idsIos;
    }else if(Platform.isAndroid){
      productID = idsAndroid;
    }
    PurchaseDetails purchase = _hasPurchased(productID);
    print("Produto de purchase em verifyPuchase: ${purchase.productID}");
    print("Status de purchase em verifyPuchase: ${purchase.status.toString()}");
    if(purchase != null && purchase.status == PurchaseStatus.purchased){
      ///liberar recurso comprado <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
      print("Lista Ilimitadas");
    }
  }

  //compra de um produto não consumível
  void _buyProduct(ProductDetails prod){
    print("Entrou no buyProduct");
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      body: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Compras dentro do aplicativo ", style: TextStyle(
              color: Colors.white, fontSize: 30,
            ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FutureBuilder<List<ProductDetails>>(
                    future: _getProducts(),
                    initialData: List<ProductDetails>(),
                    builder: (BuildContext context, AsyncSnapshot<List<ProductDetails>> products) {
                      if(products.data != null){
                        return SingleChildScrollView(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: products.data.map((item) => buildProductRow(item)).toList(),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildProductRow(ProductDetails prod){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  prod.title,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  prod.description,
                  style: TextStyle(color: Colors.black45),
                )
              ],
            ),
          ),
          RaisedButton(
            color: Colors.white,
            child: Text(prod.price,
              style: TextStyle(color: Colors.green),),
            onPressed: () => { _buyProduct(prod) },
          )
        ],
      ),
    );
  }


//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Column(
//        children: <Widget>[
//          for(var prod in _products)
//            //UI para compras disponíveis
//            if(_hasPurchased(prod.id) != null)
//              ...[
//                Text("")
//
//              ]
//            //UI se não existir compras disponíveis
//            else...[
//
//            ]
//        ],
//      ),
//    );
//  }




}
