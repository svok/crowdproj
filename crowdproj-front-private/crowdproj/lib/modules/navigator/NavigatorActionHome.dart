import 'package:crowdproj/modules/home/HomePage.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionHome extends NavigatorAction {
  final _route = HomePage.route;

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
  Object get arguments => null;

}
