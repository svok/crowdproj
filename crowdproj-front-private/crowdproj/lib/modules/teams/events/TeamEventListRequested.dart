import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamEvent.dart';

import '../TeamBloc.dart';

class TeamEventSaveRequested extends TeamEvent {
  TeamEventSaveRequested({
    this.query,
  }) : super();

  final TeamsQuery query;

  @override
  Stream<TeamsState> handle(TeamBloc TeamBloc) async* {
    final service = AppSession.get.teamsService;

    final state = TeamBloc.state as TeamsStateListing;
    yield TeamsStateListing(
      query: query,
      teams: state?.teams,
      errors: state?.errors,
      isWaiting: true,
    );

    final response = await service.getTeams(query);
    yield TeamsStateListing(
      query: query,
      teams: response.teams,
      errors: response.errors,
    );
  }
}
