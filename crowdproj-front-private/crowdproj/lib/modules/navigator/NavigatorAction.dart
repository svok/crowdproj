import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/auth/AuthPage.dart';
import 'package:crowdproj/modules/error/ErrorPage.dart';
import 'package:crowdproj/modules/error/ErrorPageArgs.dart';
import 'package:flutter/material.dart';

abstract class NavigatorAction {
  NavigatorAction(context) : navigator = Navigator.of(context), super();

  String get path;

  Object get arguments;

  WidgetBuilder get builder;

  bool get maintainState => true;

  bool get fullscreenDialog => false;

  AccessResult get hasAccess => AppSession.get.authService.isAuthenticated()
      ? AccessResult.allowed
      : AccessResult.loginRequired;

  NavigatorState navigator;
  final _authRoute = AuthPage.route;
  final _errorRoute = ErrorPage.route;

  void go() {
    switch (hasAccess) {
      case AccessResult.allowed:
        navigator.push(MaterialPageRoute(
          builder: builder,
          settings: RouteSettings(name: path, arguments: arguments),
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        ));
        return;
      case AccessResult.loginRequired:
        final settings = RouteSettings(
          name: _authRoute.pathName,
          arguments: this,
        );
        navigator.push(MaterialPageRoute(
          builder: _authRoute.builder,
          settings: settings,
        ));
        return;
      case AccessResult.denied:
        final settings = RouteSettings(
          name: _errorRoute.pathName,
          arguments: ErrorPageArgs(
            code: 403,
            badRoute: RouteSettings(name: path, arguments: arguments),
            description: "Access denied to the page due to insufficien access rights",
          ),
        );
        navigator.push(MaterialPageRoute(
          builder: _errorRoute.builder,
          settings: settings,
        ));
        return;
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
