import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj_teams/TeamsModule.dart';
import 'package:crowdproj_teams_models/models/ApiResponse.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:flutter/material.dart';

import 'TeamViewEvent.dart';
import 'TeamViewState.dart';

typedef Future<ApiResponseTeam> _TeamFunc(String teamId);

class TeamViewBloc extends Bloc<TeamViewEvent, TeamViewState> {
  TeamViewBloc({
    @required this.context,
  }) : super();

  final BuildContext context;

  @override
  TeamViewState get initialState => TeamViewState();


  @override
  Stream<TeamViewState> mapEventToState(TeamViewEvent event) async* {
    final service = TeamsModule().transportService;
    switch(event.runtimeType) {
      case TeamViewEventRead: yield* _read(event); break;
      case TeamViewEventInvite: yield* _invite(event); break;
      case TeamViewEventUnapply: yield* _genericMap(event, service.unapplyMembership); break;
      case TeamViewEventJoin: yield* _genericMap(event, service.joinMembership); break;
      case TeamViewEventApply: yield* _genericMap(event, service.applyMembership); break;
      case TeamViewEventUpdate: yield* _genericMap(event, service.getTeam); break;
      case TeamViewEventLeave: yield* _genericMap(event, service.leaveTeam); break;
      case TeamViewEventAcceptInvitation: yield* _genericMap(event, service.acceptInvitation); break;
      case TeamViewEventDenayInvitation: yield* _genericMap(event, service.denyInvitation); break;
    }
  }

  Stream<TeamViewState> _read(TeamViewEventRead event) async* {
    final service = TeamsModule().transportService;
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
        teamId: teamId,
        team: response.team,
        errors: response.errors,
      );
    }
  }

  Stream<TeamViewState> _invite(TeamViewEvent event) async* {
  }

  Stream<TeamViewState> _genericMap(TeamViewEvent event, _TeamFunc _teamFunc) async* {
    yield state.copyWith(isWaiting: true);

    final ApiResponseTeam response = await _teamFunc(state.teamId);
    yield TeamViewState(
      teamId: state.teamId,
      team: response.team,
      errors: response.errors,
    );
  }

  void inviteAction() => add(TeamViewEventInvite());
  void joinAction() => add(TeamViewEventJoin());
  void applyAction() => add(TeamViewEventApply());
  void leaveAction() => add(TeamViewEventLeave());
  void unapplyAction() => add(TeamViewEventUnapply());
  void acceptInvitationAction() => add(TeamViewEventAcceptInvitation());
  void denyInvitationAction() => add(TeamViewEventDenayInvitation());

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamBloc - Error\'s occured: $error, $stackTrace');
  }

}
