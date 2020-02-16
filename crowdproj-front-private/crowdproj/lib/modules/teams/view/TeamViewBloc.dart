import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:flutter/material.dart';

import 'TeamViewEvent.dart';
import 'TeamViewEventRead.dart';
import 'TeamViewEventUpdate.dart';
import 'TeamViewState.dart';

class TeamViewBloc extends Bloc<TeamViewEvent, TeamViewState> {
  TeamViewBloc({
    @required this.context,
  }) : super();

  final BuildContext context;

  @override
  TeamViewState get initialState => TeamViewState();

  @override
  Stream<TeamViewState> mapEventToState(TeamViewEvent event) async* {
    switch (event.runtimeType) {
      case TeamViewEventRead:
        yield* _read(event);
        break;
      case TeamViewEventUpdate:
        yield* _update(event);
        break;
    }
  }

  Stream<TeamViewState> _read(TeamViewEventRead event) async* {
    final service = AppSession.get.teamsService;
    final teamId = event.teamId;
    final team = event.team;

    if (team?.id != null) {
      yield TeamViewState(
        teamId: team.id,
        team: team,
      );
    } else {
      yield TeamViewState(
        teamId: event.teamId,
        team: Team(id: event.teamId),
        isWaiting: true,
      );

      final response = await service.getTeam(teamId);
      yield TeamViewState(
        team: response.team,
      );
    }
  }

  Stream<TeamViewState> _update(TeamViewEventUpdate event) async* {
    final service = AppSession.get.teamsService;

    yield state.copyWith(isWaiting: true);

    final response = await service.getTeam(state.teamId);
    yield TeamViewState(
      teamId: state.teamId,
      team: response.team,
      errors: response.errors,
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamBloc - Error\'s occured: $error, $stackTrace');
  }
}
