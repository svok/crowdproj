import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionError.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:crowdproj/modules/teams/TeamPageArguments.dart';
import 'package:crowdproj/modules/teams/lists/TeamsPageArgs.dart';
import 'package:crowdproj/modules/teams/update/TeamUpdatePage.dart';
import 'package:crowdproj/translations/ErrorLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TeamUpdateEventChange.dart';
import 'TeamUpdateEventRead.dart';
import 'TeamUpdateEventReset.dart';
import 'TeamUpdateEventSave.dart';
import 'TeamUpdateState.dart';
import 'TeamUpdateEvent.dart';

class TeamUpdateBloc extends Bloc<TeamUpdateEvent, TeamUpdateState> {
  TeamUpdateBloc({
    @required this.context,
  }) : super();

  final BuildContext context;

  @override
  TeamUpdateState get initialState => TeamUpdateState();

  @override
  Stream<TeamUpdateState> mapEventToState(TeamUpdateEvent event) async* {
    switch (event.runtimeType) {
      case TeamUpdateEventChange:
        yield* _changeTeam(event as TeamUpdateEventChange);
        break;
      case TeamUpdateEventRead:
        yield* _readTeam(event as TeamUpdateEventRead);
        break;
      case TeamUpdateEventSave:
        yield* _saveTeam(event as TeamUpdateEventSave);
        break;
      case TeamUpdateEventReset:
        yield* _resetTeam(event as TeamUpdateEventReset);
        break;
    }
  }

  Stream<TeamUpdateState> _readTeam(TeamUpdateEventRead event) async* {
    final service = AppSession.get.teamsService;
    final teamId = event.teamId;
    final team = event.team;

    if (team?.id != null) {
      if (team?.canUpdate != true) {
        _sendTeamError(teamId, team);
      } else {
        yield TeamUpdateState(
          teamId: team.id,
          team: team,
          teamUpdated: team.copyWith(),
        );
      }
    } else if(teamId != null) {
      yield TeamUpdateState(
        teamId: teamId,
        team: Team(id: teamId),
        teamUpdated: Team(id: teamId),
        isWaiting: true,
      );

      final response = await service.getTeam(teamId);
      final team = response.team;
      if (team?.canUpdate != true) {
        _sendTeamError(teamId, team);
      } else {
        yield TeamUpdateState(
          teamId: teamId,
          team: response.team,
          teamUpdated: response.team.copyWith(),
          errors: response.errors,
        );
      }
    } else {
      yield TeamUpdateState(
        teamId: null,
        team: Team(),
        teamUpdated: Team(),
      );
    }
  }

  _sendTeamError(String teamId, Team team) {
    final args = TeamPageArguments(teamId: teamId, team: team);
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorActionError(
      code: 403,
      badRoute: RouteSettings(
        name: TeamUpdatePage.route.pathFormatted(arguments: args),
        arguments: args,
      ),
    ));
  }

  Stream<TeamUpdateState> _saveTeam(TeamUpdateEventSave event) async* {
    final service = AppSession.get.teamsService;

    yield state.copyWith(
      isWaiting: true,
    );
    final response = await service.saveTeam(state.teamUpdated);
      yield TeamUpdateState(
        team: response.team,
        teamUpdated: response.team.copyWith(),
        errors: response.errors,
      );
  }

  Stream<TeamUpdateState> _resetTeam(TeamUpdateEventReset event) async* {
    yield state.copyWith(
      teamUpdated: state.team.copyWith(),
    );
  }

  Stream<TeamUpdateState> _changeTeam(TeamUpdateEventChange event) async* {
    yield state.copyWith(
      teamUpdated: event.team,
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamBloc - Error\'s occured: $error, $stackTrace');
  }
}
