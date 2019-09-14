import 'package:flutter/material.dart';
import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

final String produtoIos = "RC.PREMIUM.0001";
final String produtoAndroid = "rc.premium.0001";

class MarketScreen extends StatefulWidget {
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  ///instância de comunicação com as lojas
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  ///variável que reflete a viabilidade da loja no momento de execução
  bool _available = true;

  ///detelhes de produtos disponíveis nas lojas
  List<ProductDetails> _products = [];

  ///detalhes de compras realizadas no passado
  List<PurchaseDetails> _purchases = [];

  ///ouvinte para novas compras
  StreamSubscription _subscription;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _initialize() async {
    ///checando a viabilidade da loja
    _available = await _iap.isAvailable();

    if (_available) {
      await _getProducts();
      await _getPastPurchases();

      _verifyPurhase();

      ///ouvinte pata novas compras
      _subscription = _iap.purchaseUpdatedStream.listen((data) => setState(() {
            print("NOVA COMPRA");
            _purchases.addAll(data);
            _verifyPurhase();
          }));
    }
  }

  ///pega todos os produtos viáveis na loja
  Future<void> _getProducts() async {
    var productIdentify;
    if (Platform.isIOS) {
      productIdentify = produtoIos;
    } else {
      productIdentify = produtoAndroid;
    }

    ///criando um conjunto de ids do produto que queremos
    Set<String> ids = Set.from([productIdentify]);

    ///consultando detalhes do produto na loja
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    ///chamando setState
    setState(() {
      _products = response.productDetails;
    });
  }

  ///obtendo compras passadas do usuário
  Future<void> _getPastPurchases() async {
    ///retorna produtos NÃO CONSUMIVEIS. obs: esse método não retorna produtos consumíveis porque eles podem ser compados varias vezes
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();

    ///seguindo critério de completePurchase para iOS
    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        _iap.completePurchase(purchase);
      }
    }

    ///chamando setState
    setState(() {
      _purchases = response.pastPurchases;
    });
  }

  ///verificando se o usuário comprou um produto específico
  PurchaseDetails _hasPuchased(String productID) {
    ///percorre as compras para ver se tem algum id correspondente, lembrando que é para produtos NÃO CONSUMÍVEIS
    return _purchases.firstWhere((purchase) => purchase.productID == productID,
        orElse: () => null);
  }

  ///verificando compra de pruduto NÃO CONSUMÍVEL e para implementação de regra de negócio para produto CONSUMÍVEL
  void _verifyPurhase() async {
    var productIdentify;
    if (Platform.isIOS) {
      productIdentify = produtoIos;
    } else {
      productIdentify = produtoAndroid;
    }
    PurchaseDetails purchase = _hasPuchased(productIdentify);

    ///alterando SharedPreferences
    if (purchase != null && purchase.status == PurchaseStatus.purchased) {
      ///regra de negócio para produto consumível
      print("PRODUTO COMPRADO");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("RC.PREMIUM.0001", 1);
    }
  }

  ///compra do produto
  void _buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);

    ///obs: o android não faz distinção entre consumíveis e não consumíveis

    _iap.buyNonConsumable(purchaseParam: purchaseParam);

    ///se o produto fosse CONSUMÍVEL, usaria o método abaixo e seria necessário que a regra de negócio
    ///controlasse o consumo, pois para o sistema ele é consumido imediatamente.
    ///_iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }

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
      body: Center(child: _verificaPossibilidadeDeCompra(context, _products)),
    );
  }

  // ignore: missing_return
  Widget _verificaPossibilidadeDeCompra(
      BuildContext context, List<ProductDetails> products) {
    for (var prod in products) {
      //verificando se o produto já foi comprado anteriormente
      if (_hasPuchased(prod.id) != null) {
        return Container(
          margin: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  "Este recurso já foi adquirido anteriormente e está liberado para uso.",
                  style: TextStyle(fontSize: 16, color: Colors.black))
            ],
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      //texto vindo das lojas
                      Text(
                        prod.title,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        prod.description,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ]
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: FlatButton(
                  child: Text(prod.price,
                      style: TextStyle(fontSize: 16, color: Colors.white)
                  ),
                  color: Colors.green,
                  onPressed: () => _buyProduct(prod),
                ),
              )
            ],
          ),
        );
      }
    }
  }
}
