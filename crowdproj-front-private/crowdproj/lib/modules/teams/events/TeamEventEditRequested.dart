import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/teams/TeamBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/api/models/Team.dart';

import 'TeamEvent.dart';

class TeamEventEditRequested extends TeamEvent {
  TeamEventEditRequested({
    this.team,
  }) : super();

  final Team team;

  @override
  Stream<TeamsState> handle(TeamBloc TeamBloc) async* {
    final service = AppSession.get.teamsService;
    if (team == null) {
      // New team creation
      yield TeamsStateEditing(teamEdited: Team());
    } else {
      // Existing team update
      yield TeamsStateEditing(team: team, teamEdited: team, isWaiting: true);
      final response = await service.getTeam(team.id);
      print("_editEvent: ${response.team}");
      yield TeamsStateEditing(team: response.team, teamEdited: response.team);
    }
  }
}
