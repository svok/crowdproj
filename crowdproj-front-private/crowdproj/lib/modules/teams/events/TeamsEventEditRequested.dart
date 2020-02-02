import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/models/Team.dart';
import 'package:flutter/material.dart';

import 'TeamsEvent.dart';

class TeamsEventEditRequested extends TeamsEvent {
  TeamsEventEditRequested({
    this.team,
  }) : super();

  final Team team;

  @override
  Stream<TeamsState> handle(BuildContext context) async* {
    final service = AppSession.get.teamsService;
    if (team == null) {
      // New team creation
      yield TeamsStateEditing(teamEdited: Team());
    } else {
      // Existing team update
      yield TeamsStateWaiting();
      final response = await service.getTeam(team.id);
      print("_editEvent: ${response.team}");
      yield TeamsStateEditing(team: response.team, teamEdited: response.team);
    }
  }
}
