import 'package:crowdproj/modules/error/ErrorPage.dart';
import 'package:crowdproj/modules/error/ErrorPageArgs.dart';
import 'package:crowdproj/modules/teams/TeamsPageEdit.dart';
import 'package:flutter/material.dart';

abstract class NavigatorAction {

  NavigatorAction(this._navigator): super();

  String get path;
  Object get arguments;
  NavigatorState _navigator;

  void go() {
    print("NavigatorAction.go");
    print("REDIRECTING to $path");
    _navigator.pushNamed(path, arguments: arguments);
  }
}

class NavigatorActionPop extends NavigatorAction {
  NavigatorActionPop(NavigatorState navigatorState): super(navigatorState);
  @override
  Object get arguments => null;

  @override
  String get path => null;
  void go() {
    if (_navigator.canPop()) _navigator.pop();
  }
}

class NavigatorActionError extends NavigatorAction {
  NavigatorActionError(NavigatorState navigatorState, {
    this.code,
    this.badRoute,
    this.description,
  }) : super(navigatorState);

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
  Object get arguments => ErrorPageArgs(
        code: code,
        badRoute: badRoute,
        description: description,
      );
}

class NavigatorActionTeamsEdit extends NavigatorAction {
  NavigatorActionTeamsEdit(NavigatorState navigatorState, {
    this.teamId,
  }) : super(navigatorState);
  String teamId;

  final _route = TeamsPageEdit.route;

  @override
  String get path {
    print("NavigatorActionTeamsEdit.path: ${_route.pathName}");
    return _route.pathFormatted(
      settings: RouteSettings(
        name: _route.pathName,
        arguments: arguments,
      ),
    );
  }

  @override
  TeamsPageEditArguments get arguments =>
      TeamsPageEditArguments(teamId: teamId);
}
