import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/team/states/TeamState.dart';
import 'package:crowdproj/modules/team/states/TeamStateEditing.dart';
import 'package:crowdproj/api/models/Team.dart';

import '../TeamBloc.dart';
import 'TeamEvent.dart';

class TeamEventPreviewRequested extends TeamEvent {
  TeamEventPreviewRequested({
    Team team,
  }) : super(team: team);

  @override
  Stream<TeamState> handle(TeamBloc TeamBloc) async* {
    print("PREVIEW EVENT: ${team}");
    yield TeamStateEditing(
      team: team,
    );
  }

  @override
  List<Object> get props => [team];
}
