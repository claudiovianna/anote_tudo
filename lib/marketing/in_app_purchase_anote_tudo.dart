import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseAnoteTudo extends StatefulWidget {
  @override
  _InAppPurchaseAnoteTudoState createState() => _InAppPurchaseAnoteTudoState();
}

class _InAppPurchaseAnoteTudoState extends State<InAppPurchaseAnoteTudo> {

  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  List<String> _noConsumables = [];
  bool _isvailable = false;
  bool _purchasePending = false;
  bool _loading = true ;
  String _queryProductError = null;

  @override
  void initState() {
    final Stream purchaseUpdates = InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdates.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      //Tratar erro se houver
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  //verificando a viabilidade das lojas
  Future<bool> _storeAvailable() async {
    final bool available = await InAppPurchaseConnection.instance.isAvailable();
    if(available){
      print("Loja de Apps viável");
      return true;
    }else{
      print("Loja de Apps inviável");
      return false;
    }
  }

  //recuperando das lojas os produtos disponíveis
  Future<List<ProductDetails>> _productsForSale() async {
    const kIdsIos = ['RC.PREMIUM.0001'];
    const kIdsAndroid = ['rc.premium.0001'];

    Set<String> _kIds;
    if(Platform.isIOS){
      _kIds = kIdsIos.toSet();
    }else if(Platform.isAndroid){
      _kIds = kIdsAndroid.toSet();
    }

    final ProductDetailsResponse response = await InAppPurchaseConnection.instance.queryProductDetails(_kIds);
    if(!response.notFoundIDs.isEmpty){
      //tratar o erro
      print("Erro ao recuperar produtos disponíveis nas lojas");
    }
    List<ProductDetails> products = response.productDetails;
    return products;
  }

  //recuperando compras já realizadas no passado




  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if(purchaseDetails.status == PurchaseStatus.pending){
        showPendingUI();
      }else{
        if(purchaseDetails.status == PurchaseStatus.error){
          handleError(purchaseDetails.error);
        }else if(await _verifyPurchase(purchaseDetails)){
          deliverProduct(purchaseDetails);
        }
      }
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    if(purchaseDetails.status == PurchaseStatus.purchased){
      return Future<bool>.value(true);
    }else{
      return Future<bool>.value(false);
    }
  }

  void deliverProduct(PurchaseDetails purchaseDetails) {

  }

}
