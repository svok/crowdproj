import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamEvent.dart';
import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';

import '../TeamBloc.dart';

class TeamEventSaveRequested extends TeamEvent {
  TeamEventSaveRequested({
    this.team,
  }) : super();

  final Team team;

  @override
  Stream<TeamsState> handle(TeamBloc TeamBloc) async* {
    final service = AppSession.get.teamsService;

    yield TeamsStateEditing(
      team: team,
      isWaiting: true,
    );

    final response = await service.saveTeam(team);
    if (response.status == ApiResponseStatuses.success) {
      yield TeamsStateViewing(team: response.team);
    } else {
      yield TeamsStateEditing(
        team: team,
        errors: response.errors,
      );
    }
  }
}
