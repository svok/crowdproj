import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/error/ErrorPage.dart';
import 'package:crowdproj/modules/error/ErrorPageArgs.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionDefaultAbstarct.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionError extends NavigatorActionDefaultAbstract {
  NavigatorActionError({
    this.code,
    this.badRoute,
    this.description,
  }) : super();

  final int code;
  final RouteSettings badRoute;
  final String description;

  @override
  RouteDescription get route=> ErrorPage.route;

  @override
  Object get arguments => ErrorPageArgs(
    code: code,
    badRoute: badRoute,
    description: description,
  );

  @override
  AccessResult get hasAccess => AccessResult.allowed;

  @override
  List<Object> get props => [code, badRoute, description];

}
