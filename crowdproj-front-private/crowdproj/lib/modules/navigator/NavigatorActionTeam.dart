import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/navigator/NavigatorAction.dart';
import 'package:crowdproj/modules/team/TeamPage.dart';
import 'package:crowdproj/modules/team/TeamPageArguments.dart';
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
  TeamPageArguments get arguments =>
      TeamPageArguments(teamId: teamId);

  @override
  Future<NavigatorAction> go(NavigatorState navigator) async {
    super.go(navigator);
    final context = navigator.context;
//    BlocProvider.of<TeamBloc>(context).add(TeamsEventTeamInit(teamId: teamId));
  }

  @override
  List<Object> get props => [];
}
