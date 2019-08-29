import 'package:flutter/material.dart';



class ItensDeCompra extends StatefulWidget {
  @override
  _ItensDeCompraState createState() => _ItensDeCompraState();
}

class _ItensDeCompraState extends State<ItensDeCompra> {
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
          ],
        ),
      ),
    );
  }
}
