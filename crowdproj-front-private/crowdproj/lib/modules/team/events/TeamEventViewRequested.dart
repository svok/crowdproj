import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/team/states/TeamState.dart';
import 'package:crowdproj/modules/team/states/TeamStateViewing.dart';
import 'package:crowdproj/api/models/ApiResponse.dart';

import '../TeamBloc.dart';
import 'TeamEvent.dart';

class TeamEventViewRequested extends TeamEvent {
  TeamEventViewRequested({
    Team team,
    this.teamId,
  }) : super(team: team);

  final String teamId;

  @override
  Stream<TeamState> handle(TeamBloc teamBloc) async* {
    final service = AppSession.get.teamsService;

    if (team?.id != null) {
      yield TeamStateViewing(team: team);
    } else {
      final state = teamBloc.state;
      yield TeamStateViewing(
        team: state?.team,
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

  @override
  List<Object> get props => [teamId, team];
}
