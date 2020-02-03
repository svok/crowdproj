import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:flutter/material.dart';

import '../TeamPage.dart';
import '../TeamBloc.dart';
import 'TeamEvent.dart';

class TeamEventViewRequested extends TeamEvent {
  TeamEventViewRequested({
    this.teamId,
  }) : super();

  final String teamId;

  @override
  Stream<TeamsState> handle(TeamBloc TeamBloc) async* {
    final service = AppSession.get.teamsService;
    final routeDescription = TeamPage.route;
    final routeSettings = RouteSettings(
      name: routeDescription.pathName,
      arguments: TeamsPageEditArguments(teamId: teamId),
    );

    final stateEditing = TeamBloc.state as TeamsStateEditing;
    final stateViewing = TeamBloc.state as TeamsStateViewing;
    yield TeamsStateViewing(
      team: stateEditing?.team ?? stateViewing.team,
      isWaiting: true,
    );

    final response = await service.getTeam(teamId);
    if (response.status == ApiResponseStatuses.success) {
      yield TeamsStateViewing(team: response.team);
    } else {
      // Error handling must be here!!
    }
  }
}
