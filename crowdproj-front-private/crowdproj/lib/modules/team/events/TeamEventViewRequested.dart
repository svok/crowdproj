import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/team/states/TeamState.dart';
import 'package:crowdproj/modules/team/states/TeamStateEditing.dart';
import 'package:crowdproj/modules/team/states/TeamStateViewing.dart';
import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:flutter/material.dart';

import '../TeamPage.dart';
import '../TeamBloc.dart';
import '../TeamPageArguments.dart';
import 'TeamEvent.dart';

class TeamEventViewRequested extends TeamEvent {
  TeamEventViewRequested({
    this.teamId,
  }) : super();

  final String teamId;

  @override
  Stream<TeamState> handle(TeamBloc TeamBloc) async* {
    final service = AppSession.get.teamsService;
    final routeDescription = TeamPage.route;
    final routeSettings = RouteSettings(
      name: routeDescription.pathName,
      arguments: TeamPageArguments(teamId: teamId),
    );

    final stateEditing = TeamBloc.state as TeamStateEditing;
    final stateViewing = TeamBloc.state as TeamStateViewing;
    yield TeamStateViewing(
      team: stateEditing?.team ?? stateViewing.team,
      isWaiting: true,
    );

    final response = await service.getTeam(teamId);
    if (response.status == ApiResponseStatuses.success) {
      yield TeamStateViewing(team: response.team);
    } else {
      // Error handling must be here!!
    }
  }
}
