import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamsEventEditRequested.dart';
import 'package:crowdproj/modules/teams/events/TeamsEventViewRequested.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamsBloc.dart';
import 'TeamsEvent.dart';

class TeamsEventTeamInit extends TeamsEvent {
  TeamsEventTeamInit({
    this.teamId,
  }) : super();

  final String teamId;

  @override
  Stream<TeamsState> handle(BuildContext context) async* {
    final teamsBloc = BlocProvider.of<TeamsBloc>(context);
    if (teamId == null) {
      teamsBloc.add(TeamsEventEditRequested());
    } else {
      teamsBloc.add(TeamsEventViewRequested(teamId: teamId));
    }
  }
}
