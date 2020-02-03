import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/navigator/NavigatorAction.dart';
import 'package:crowdproj/modules/teams/TeamPage.dart';
import 'package:flutter/material.dart';

import 'NavigatorActionDefaultAbstarct.dart';

class NavigatorActionTeam extends NavigatorActionDefaultAbstract {
  NavigatorActionTeam({
    this.teamId,
  }) : super();
  String teamId;

  @override
  RouteDescription get route => TeamPage.route;

  @override
  TeamsPageEditArguments get arguments =>
      TeamsPageEditArguments(teamId: teamId);

  @override
  Future<NavigatorAction> go(NavigatorState navigator) async {
    super.go(navigator);
    final context = navigator.context;
//    BlocProvider.of<TeamsBloc>(context).add(TeamsEventTeamInit(teamId: teamId));
  }

  @override
  List<Object> get props => [];
}
