import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/modules/team/states/TeamState.dart';

import '../TeamBloc.dart';
import 'TeamEvent.dart';
import 'TeamEventEditRequested.dart';
import 'TeamEventViewRequested.dart';

class TeamEventTeamInit extends TeamEvent {
  TeamEventTeamInit({
    Team team,
    this.teamId,
  }) : super(team: team);

  final String teamId;

  @override
  Stream<TeamState> handle(TeamBloc TeamBloc) async* {
    if (team?.id != null) {
      print("TeamEventTeamInit. team");
      TeamBloc.add(TeamEventViewRequested(team:  team));
    } else if (teamId == null) {
      print("TeamEventTeamInit. create");
      TeamBloc.add(TeamEventEditRequested());
    } else {
      print("TeamEventTeamInit. teamId");
      TeamBloc.add(TeamEventViewRequested(teamId: teamId));
    }
  }

  @override
  List<Object> get props => [teamId, team];
}
