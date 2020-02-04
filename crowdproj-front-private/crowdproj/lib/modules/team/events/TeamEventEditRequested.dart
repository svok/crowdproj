import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/team/states/TeamState.dart';
import 'package:crowdproj/modules/team/states/TeamStateEditing.dart';
import 'package:crowdproj/api/models/Team.dart';

import '../TeamBloc.dart';
import 'TeamEvent.dart';

class TeamEventEditRequested extends TeamEvent {
  TeamEventEditRequested({
    Team team,
  }) : super(team: team);

  @override
  Stream<TeamState> handle(TeamBloc TeamBloc) async* {
    final service = AppSession.get.teamsService;
    if (team == null) {
      // New team creation
      yield TeamStateEditing(teamEdited: Team());
    } else {
      // Existing team update
      yield TeamStateEditing(team: team, teamEdited: team, isWaiting: true);
      final response = await service.getTeam(team.id);
      print("_editEvent: ${response?.team?.id}");
//      yield TeamStateEditing(team: response.team, teamEdited: response.team);
      yield TeamStateEditing(team: team, teamEdited: team);
    }
  }

  @override
  List<Object> get props => [team];
}
