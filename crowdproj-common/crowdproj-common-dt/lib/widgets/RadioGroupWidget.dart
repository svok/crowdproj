import 'package:flutter/material.dart';

class RadioGroupWidget<T> extends StatelessWidget {
  RadioGroupWidget({
    Key key,
    this.axis: Axis.horizontal,
    this.children,
  }) : super(key: key);

  final Axis axis;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    switch(axis) {
      case Axis.vertical: return Column(
        children: children,
      );
      case Axis.horizontal: return Wrap(
        children: children,
      );
    }
  }
}
