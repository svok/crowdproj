import 'package:crowdproj/modules/error/ErrorPage.dart';
import 'package:crowdproj/modules/error/ErrorPageArgs.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionError extends NavigatorAction {
  NavigatorActionError({
    this.code,
    this.badRoute,
    this.description,
  }) : super();

  int code;
  RouteSettings badRoute;
  String description;

  final _route = ErrorPage.route;

  @override
  String get path => _route.pathFormatted(
    settings: RouteSettings(
      name: _route.pathName,
      arguments: arguments,
    ),
  );

  @override
  WidgetBuilder get builder => _route.builder;

  @override
  Object get arguments => ErrorPageArgs(
    code: code,
    badRoute: badRoute,
    description: description,
  );

  @override
  AccessResult get hasAccess => AccessResult.allowed;

}
