import 'package:flutter/material.dart';

class EmptyApp extends StatelessWidget {
  EmptyApp({Key key, @required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: child,
        ),
      );
}
