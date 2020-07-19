import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj_teams/TeamsModule.dart';
import 'package:crowdproj_teams_models/models/ApiResponse.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:crowdproj_teams_models/models/TeamAccess.dart';
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
  }) : super(TeamUpdateState());

  final BuildContext context;

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
    final service = TeamsModule().transportService;
    final teamId = event.teamId;
    final team = event.team;

    if (team?.id != null) {
      if (team?.can(TeamAccess.UPDATE) != true) {
        _sendTeamError(teamId, team);
      } else {
        yield TeamUpdateState(
          teamId: team.id,
          team: team,
          teamUpdated: team.copyWith(),
        );
      }
    } else if (teamId != null) {
      yield TeamUpdateState(
        teamId: teamId,
        team: Team(id: teamId),
        teamUpdated: Team(id: teamId),
        isWaiting: true,
      );

      final response = await service.getTeam(teamId);
      final team = response.team;
      if (team?.can(TeamAccess.UPDATE) != true) {
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
//    // target style
//    final args = TeamPageArguments(teamId: teamId, team: team);
//    TeamsModule().locateTo(context, routeDescription = ErrorPage.route, arguments = ErroPageArgs(
//      code: 403,
//      badRoute: RouteSettings(
//        name: TeamUpdatePage.route.pathFormatted(arguments: args),
//        arguments: args,
//      ),
//    ));

    // Old style
//    BlocProvider.of<NavigatorBloc>(context).add(NavigatorActionError(
//      code: 403,
//      badRoute: RouteSettings(
//        name: TeamUpdatePage.route.pathFormatted(arguments: args),
//        arguments: args,
//      ),
//    ));
  }

  Stream<TeamUpdateState> _saveTeam(TeamUpdateEventSave event) async* {
    final service = TeamsModule().transportService;

    yield state.copyWith(
      isWaiting: true,
    );
    ApiResponseTeam response;
    try {
      response = await service.saveTeam(state.teamUpdated);
    } catch (e, stacktrace) {
      print("Error in TeamUpdateBloc::_saveTeam: $e\n$stacktrace");
      response = ApiResponseTeam(
          teams: [],
          status: ApiResponseStatuses.error,
          errors: [
            ApiError(
              code: "unknown",
              field: "",
              message: e.toString(),
              description: e.toString(),
              level: ErrorLevels.fatal,
            )
          ]);
    }
    yield TeamUpdateState(
      team: response.team,
      teamUpdated: response.team?.copyWith(),
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
    print('TeamUpdateBloc - Error\'s occured: $error, $stackTrace');
  }
}
