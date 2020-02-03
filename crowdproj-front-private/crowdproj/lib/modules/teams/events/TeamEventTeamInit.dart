import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamEventEditRequested.dart';
import 'package:crowdproj/modules/teams/events/TeamEventViewRequested.dart';

import '../TeamBloc.dart';
import 'TeamEvent.dart';

class TeamEventTeamInit extends TeamEvent {
  TeamEventTeamInit({
    this.teamId,
  }) : super();

  final String teamId;

  @override
  Stream<TeamsState> handle(TeamBloc TeamBloc) async* {
    if (teamId == null) {
      TeamBloc.add(TeamEventEditRequested());
    } else {
      TeamBloc.add(TeamEventViewRequested(teamId: teamId));
    }
  }
}
