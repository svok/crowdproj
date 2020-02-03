import 'package:crowdproj/modules/team/states/TeamState.dart';

import '../TeamBloc.dart';
import 'TeamEvent.dart';
import 'TeamEventEditRequested.dart';
import 'TeamEventViewRequested.dart';

class TeamEventTeamInit extends TeamEvent {
  TeamEventTeamInit({
    this.teamId,
  }) : super();

  final String teamId;

  @override
  Stream<TeamState> handle(TeamBloc TeamBloc) async* {
    if (teamId == null) {
      TeamBloc.add(TeamEventEditRequested());
    } else {
      TeamBloc.add(TeamEventViewRequested(teamId: teamId));
    }
  }
}
