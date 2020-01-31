import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionPop extends NavigatorAction {
  NavigatorActionPop(BuildContext context): super(context);
  @override
  String get path => null;

  @override
  WidgetBuilder get builder => null;

  @override
  Object get arguments => null;

  void go() {
    if (navigator.canPop()) navigator.pop();
  }
}
