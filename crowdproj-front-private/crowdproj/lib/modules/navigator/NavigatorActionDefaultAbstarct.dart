import 'package:crowdproj/common/RouteDescription.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

abstract class NavigatorActionDefaultAbstract extends NavigatorAction {
  RouteDescription get route;

  @override
  String get path {
    return route.pathFormatted(
      arguments: arguments,
    );
  }

  @override
  WidgetBuilder get builder => route.builder;

  @override
  Object get arguments => null;
}
