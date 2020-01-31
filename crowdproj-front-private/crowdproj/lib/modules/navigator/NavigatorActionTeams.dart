import 'package:crowdproj/modules/teams/TeamsPage.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionTeams extends NavigatorAction {
  final _route = TeamsPage.route;

  @override
  String get path {
    print("NavigatorActionTeams.path: ${_route.pathName}");
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
  TeamsPage get arguments => null;

}
