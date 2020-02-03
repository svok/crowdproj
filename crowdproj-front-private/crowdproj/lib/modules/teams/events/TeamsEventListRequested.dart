import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamsEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamsBloc.dart';

class TeamsEventSaveRequested extends TeamsEvent {
  TeamsEventSaveRequested({
    this.query,
  }) : super();

  final TeamsQuery query;

  @override
  Stream<TeamsState> handle(BuildContext context) async* {
//    final navigatorBloc = BlocPr41.ovider.of<NavigatorBloc>(context);
    final teamsBloc = BlocProvider.of<TeamsBloc>(context);
    final service = AppSession.get.teamsService;

    yield teamsBloc.state..isWaiting = true;

    final response = await service.getTeams(query);
    yield TeamsStateListing(
      query: query,
      teams: response.teams,
      errors: response.errors,
    );
  }
}
