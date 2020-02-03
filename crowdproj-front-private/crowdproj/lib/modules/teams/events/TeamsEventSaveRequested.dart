import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamsEvent.dart';
import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamsBloc.dart';

class TeamsEventSaveRequested extends TeamsEvent {
  TeamsEventSaveRequested({
    this.team,
  }) : super();

  final Team team;

  @override
  Stream<TeamsState> handle(BuildContext context) async* {
    final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    final teamsBloc = BlocProvider.of<TeamsBloc>(context);
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
