import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class AlertRFlutter {
  String _title;
  String _content;
  String _titleActionButton;
  String titleActionCancelButton;
  BuildContext _context;

  var _alertStyleErro = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle:
        TextStyle(color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),
  );

  var _alertStyleSuccess = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
        color: Color(0xFF00CD00), fontSize: 25, fontWeight: FontWeight.bold),
  );

  var _alertStyleWarning = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
        color: Color(0xFFFF8C00), fontSize: 25, fontWeight: FontWeight.bold),
  );

  //Construtores
  AlertRFlutter(this._context, this._title, this._content, this._titleActionButton);
  AlertRFlutter.alertTwoButtons(this._context, this._title, this._content, this._titleActionButton, this.titleActionCancelButton);


  //Alerta de ERRO
  Alert alertErrorWithOneButton() {
    return Alert(
        context: _context,
        style: _alertStyleErro,
        type: AlertType.error,
        title: _title,
        desc: _content,
        buttons: [
          DialogButton(
            child: Text(
              _titleActionButton,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(_context);
            },
            width: 200,
            color: Color(0xFFCFCFCF),
          ),
        ]);
  }

//Alerta de Sucesso
  Alert alertSuccessWithOneButton(Function function) {
    return Alert(
        context: _context,
        style: _alertStyleSuccess,
        type: AlertType.success,
        title: _title,
        desc: _content,
        buttons: [
          DialogButton(
            child: Text(
              _titleActionButton,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              //Navigator.pop(_context);
              function();
            },
            width: 200,
            color: Color(0xFFCFCFCF),
          ),
        ]);
  }

  //Alerta de ATENÇÃO
  Alert alertWarningWithOneButton() {
    return Alert(
        context: _context,
        style: _alertStyleWarning,
        type: AlertType.warning,
        title: _title,
        desc: _content,
        buttons: [
          DialogButton(
            child: Text(
              _titleActionButton,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(_context);
            },
            width: 200,
            color: Colors.grey[400],
          ),
        ]);
  }
  //Alerta de ATENÇÃO COM DOIS BOTÕES
  Alert alertWarningWithTwoButtons(Function functionCancel, Function functionOk){
    return Alert(
        context: _context,
        style: _alertStyleWarning,
        type: AlertType.warning,
        title: _title,
        desc: _content,
        buttons: [
          DialogButton(
            child: Text(
              titleActionCancelButton,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              //Navigator.pop(_context);
              functionCancel();
            },
            width: 200,
            color: Colors.grey[400],
          ),
          DialogButton(
            child: Text(
              _titleActionButton,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              //Navigator.pop(_context);
              functionOk();
            },
            width: 200,
            color: Colors.green[400],
          ),
        ]
    );
  }
}
