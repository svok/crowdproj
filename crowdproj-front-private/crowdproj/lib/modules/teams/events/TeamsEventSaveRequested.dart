import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamsEvent.dart';
import 'package:crowdproj/modules/teams/models/ApiResponse.dart';
import 'package:crowdproj/modules/teams/models/Team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamsEventSaveRequested extends TeamsEvent {
  TeamsEventSaveRequested({
    this.team,
  }) : super();

  final Team team;

  @override
  Stream<TeamsState> handle(BuildContext context) async* {
    final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    final service = AppSession.get.teamsService;
    yield TeamsStateWaiting();
    final response = await service.saveTeam(team);
    if (response.status == ApiResponseStatuses.success) {
      yield TeamsStateViewing(team: team);
    } else {
      yield TeamsStateEditing(
        team: team,
        errors: response.errors,
      );
    }
  }
}
