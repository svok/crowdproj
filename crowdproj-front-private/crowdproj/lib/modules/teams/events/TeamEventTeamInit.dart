import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamEventEditRequested.dart';
import 'package:crowdproj/modules/teams/events/TeamEventViewRequested.dart';

import '../TeamsBloc.dart';
import 'TeamEvent.dart';

class TeamEventTeamInit extends TeamEvent {
  TeamEventTeamInit({
    this.teamId,
  }) : super();

  final String teamId;

  @override
  Stream<TeamsState> handle(TeamsBloc teamsBloc) async* {
    if (teamId == null) {
      teamsBloc.add(TeamEventEditRequested());
    } else {
      teamsBloc.add(TeamEventViewRequested(teamId: teamId));
    }
  }
}
