import 'package:crowdproj/modules/teams/TeamsPageEdit.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionTeams extends NavigatorAction {
  NavigatorActionTeams(BuildContext context) : super(context);
  String teamId;

  final _route = TeamsPageEdit.route;

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
  TeamsPageEditArguments get arguments =>
      TeamsPageEditArguments(teamId: teamId);
}
