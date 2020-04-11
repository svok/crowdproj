
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormLinkWidget extends StatelessWidget {

  FormLinkWidget({
    @required this.label,
    this.onPressed,
  });

  String label;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new InkWell(
        child: new Text(
          label,
          style: new TextStyle(color: Colors.blueAccent),
        ),
        onTap: onPressed
      ),
    );
  }
}