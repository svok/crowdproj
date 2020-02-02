import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionError.dart';
import 'package:flutter/material.dart';

abstract class NavigatorAction {

  String get path;

  Object get arguments;

  WidgetBuilder get builder;

  bool get maintainState => true;

  bool get fullscreenDialog => false;

  AccessResult get hasAccess => AppSession.get.authService.isAuthenticated()
      ? AccessResult.allowed
      : AccessResult.loginRequired;

  Future<NavigatorAction> go(NavigatorState navigator) async {
    switch (hasAccess) {
      case AccessResult.allowed:
        navigator.push(MaterialPageRoute(
          builder: builder,
          settings: RouteSettings(name: path, arguments: arguments),
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        ));
        return null;
      case AccessResult.denied:
        return NavigatorActionError(
          code: 403,
          badRoute: RouteSettings(name: path, arguments: arguments),
          description:
              "Access denied to the page due to insufficien access rights",
        );
      default:
        throw UnimplementedError("Access type ${hasAccess} is not implemented");
    }
  }
}

enum AccessResult {
  allowed,
  loginRequired,
  denied,
}
