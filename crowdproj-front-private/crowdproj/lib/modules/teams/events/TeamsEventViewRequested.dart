import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/models/ApiResponse.dart';
import 'package:flutter/material.dart';

import '../TeamsPageEdit.dart';
import 'TeamsEvent.dart';

class TeamsEventViewRequested extends TeamsEvent {
  TeamsEventViewRequested({
    this.teamId,
  }) : super();

  final String teamId;

  @override
  Stream<TeamsState> handle(BuildContext context) async* {
    final service = AppSession.get.teamsService;
    final routeDescription = TeamsPageEdit.route;
    final routeSettings = RouteSettings(
      name: routeDescription.pathName,
      arguments: TeamsPageEditArguments(teamId: teamId),
    );

    yield TeamsStateWaiting();
    final response = await service.getTeam(teamId);
    if (response.status == ApiResponseStatuses.success) {
      yield TeamsStateViewing(team: response.team);
    } else {
      // Error handling must be here!!
    }
  }
}
