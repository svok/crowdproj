
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';

class FormSubmitButtonWidget extends StatelessWidget {

  FormSubmitButtonWidget({
    this.key,
    @required this.label,
    this.onPressed,
  }): super(key: key);

  Key key;
  String label;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      padding: new EdgeInsets.all(20.0),
      child: new RaisedButton(
        child: new Text(
          label,
          style: new TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
        color: Colors.blue,
      ),
      margin: new EdgeInsets.only(
        top: 10.0,
      ),
    );
  }
}
