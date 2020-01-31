import 'package:crowdproj/modules/auth/AuthPage.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionAuth extends NavigatorAction {
  NavigatorActionAuth({
    this.goBack,
  }) : super();
  NavigatorAction goBack;

  final _route = AuthPage.route;

  @override
  String get path {
    return _route.pathFormatted(
      settings: RouteSettings(
        name: _route.pathName,
        arguments: arguments,
      ),
    );
  }

  @override
  WidgetBuilder get builder => _route.builder;

  @override
  Object get arguments => goBack;

}
