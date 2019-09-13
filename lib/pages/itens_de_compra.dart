import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/billing_client_wrappers.dart';
import 'package:in_app_purchase/in_app_purchase.dart';



class ItensDeCompra extends StatefulWidget {
  @override
  _ItensDeCompraState createState() => _ItensDeCompraState();
}

class _ItensDeCompraState extends State<ItensDeCompra> {

  StreamSubscription<List<PurchaseDetails>> _subscription;

  @override
  void initState() {
    final Stream purchaseUpdates = InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdates.listen((purchases) {
      print("Subscription atualizada: $_subscription");
    }, onDone: () {
      _subscription.cancel();
      print("Não houve compra do recurso. Subscription Cancelada");
    }, onError: (error) {
      print("Houve erro na compra do recurso!!!");
    });
    super.initState();
  }
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
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
                    future: retrieveProducts(),
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


//  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Roberto
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.green[300],
//      body: Container(
//        margin: EdgeInsets.all(50),
//        child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text("Compras dentro do aplicativo ", style: TextStyle(
//              color: Colors.white, fontSize: 30,
//            ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Roberto




  Future<List<ProductDetails>> retrieveProducts() async {
    final bool available = await InAppPurchaseConnection.instance.isAvailable();
    if(!available){
      //se loja não for viável...
      print("A loja não está viável");
      return null;
    }else{
      final kIdsIos = ['RC.PREMIUM.0001'];
      final kIdsAndroid = ['rc.premium.0001'];
      Set<String> _kIds;
      if(Platform.isIOS){
        _kIds = kIdsIos.toSet();
      }else if(Platform.isAndroid){
        _kIds = kIdsAndroid.toSet();
      }
      final ProductDetailsResponse response = await InAppPurchaseConnection.instance.queryProductDetails(_kIds);
      if(response.notFoundIDs.isNotEmpty) {
        //se houver erro
        print("Produto não encontrado na loja");
      }
      List<ProductDetails> products = response.productDetails;
      return products;
      //return Future(() => response.productDetails);
    }
  }

  void purchaseItem(ProductDetails productDetails) async {

      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      if((Platform.isIOS && productDetails.skProduct.subscriptionPeriod == null) || (Platform.isAndroid && productDetails.skuDetail.type == SkuType.subs)) {
        InAppPurchaseConnection.instance.buyConsumable(purchaseParam: purchaseParam);

        if(Platform.isIOS){
          final QueryPurchaseDetailsResponse response = await InAppPurchaseConnection.instance.queryPastPurchases();
          if(response.error != null){
            print("Ocorreu erro na busca por compras passadas. Erro: ${response.error.toString()}");
          }else{
            for(PurchaseDetails purchaseDetails in response.pastPurchases) {
              InAppPurchaseConnection.instance.completePurchase(purchaseDetails);
              print("ProductID: ${purchaseDetails.productID}");
              print("Status de compra: ${purchaseDetails.status.toString()}");
            }
          }
        }
      }else{
        InAppPurchaseConnection.instance.buyNonConsumable(purchaseParam: purchaseParam);

        if(Platform.isIOS){
          final QueryPurchaseDetailsResponse response = await InAppPurchaseConnection.instance.queryPastPurchases();
          if(response.error != null){
            print("Ocorreu erro na busca por compras passadas. Erro: ${response.error.toString()}");
          }else{
            for(PurchaseDetails purchaseDetails in response.pastPurchases) {
              InAppPurchaseConnection.instance.completePurchase(purchaseDetails);
              print("ProductID: ${purchaseDetails.productID}");
              print("Status de compra: ${purchaseDetails.status.toString()}");
            }
          }
        }
      }
  }

  Widget buildProductRow(ProductDetails productDetails){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  productDetails.title,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  productDetails.description,
                  style: TextStyle(color: Colors.black45),
                )
              ],
            ),
          ),
          RaisedButton(
            color: Colors.white,
            child: Text(productDetails.price,
              style: TextStyle(color: Colors.green),),
            onPressed: () => { purchaseItem(productDetails) },
          )
        ],
      ),
    );
  }





}