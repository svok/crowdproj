import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/team/states/TeamState.dart';
import 'package:crowdproj/modules/team/states/TeamStateEditing.dart';
import 'package:crowdproj/modules/team/states/TeamStateViewing.dart';
import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';

import '../TeamBloc.dart';
import 'TeamEvent.dart';

class TeamEventSaveRequested extends TeamEvent {
  TeamEventSaveRequested({
    Team team,
  }) : super(team: team);

  @override
  Stream<TeamState> handle(TeamBloc TeamBloc) async* {
    final service = AppSession.get.teamsService;

    yield TeamStateEditing(
      team: team,
      isWaiting: true,
    );
    final response = await service.saveTeam(team);
    if (response.status == ApiResponseStatuses.success) {
      yield TeamStateViewing(team: response.team);
    } else {
      yield TeamStateEditing(
        team: team,
        errors: response.errors,
      );
    }
  }

  @override
  List<Object> get props => [team];
}
