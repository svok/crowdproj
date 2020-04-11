import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionPop extends NavigatorAction {
  NavigatorActionPop(): super();
  @override
  String get path => null;

  @override
  WidgetBuilder get builder => null;

  @override
  Object get arguments => null;

  Future<NavigatorAction> go(NavigatorState navigatorState) async {
    if (navigatorState.canPop()) navigatorState.pop();
    return null;
  }

  @override
  List<Object> get props => [];
}
