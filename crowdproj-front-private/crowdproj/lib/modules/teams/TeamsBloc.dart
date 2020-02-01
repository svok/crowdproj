import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/modules/teams/TeamsEvent.dart';
import 'package:crowdproj/modules/teams/TeamsService.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/models/ApiResponse.dart';
import 'package:flutter/material.dart';

import 'TeamsPageEdit.dart';
import 'models/Team.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc({
    @required this.service,
  }) : super();

  final TeamsService service;
//  final GlobalKey<NavigatorState> navigatorKey;

  @override
  TeamsState get initialState => TeamsStateNothing();

  @override
  Stream<TeamsState> mapEventToState(TeamsEvent event) async* {
    switch (event.runtimeType) {
      case TeamsEventViewRequested:
        yield* _viewEvent(event);
        break;
      case TeamsEventSaveRequested:
        yield* _saveEvent(event);
        break;
      case TeamsEventEditRequested:
        yield* _editEvent(event);
        break;
      default:
        yield TeamsStateNothing();
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamsBloc - Error\'s occured: $error, $stackTrace');
  }

  Stream<TeamsState> _saveEvent(TeamsEventSaveRequested event) async* {
    yield TeamsStateWaiting();
    final response = await service.saveTeam(event.team);
    if (response.status == ApiResponseStatuses.success) {
      yield TeamsStateViewing(team: event.team);
    } else {
      yield TeamsStateEditing(
        team: event.team,
        errors: response.errors,
      );
    }
  }

  Stream<TeamsState> _editEvent(TeamsEventEditRequested event) async* {
    if (event.team == null) {
      // New team creation
      yield TeamsStateEditing(teamEdited: Team());
    } else {
      // Existing team update
      yield TeamsStateWaiting();
      final response = await service.getTeam(event.team.id);
      print("_editEvent: ${response.team}");
      yield TeamsStateEditing(team: response.team, teamEdited: response.team);
    }
  }

  Stream<TeamsState> _viewEvent(TeamsEventViewRequested event) async* {
    final routeDescription = TeamsPageEdit.route;
    final routeSettings = RouteSettings(
      name: routeDescription.pathName,
      arguments: TeamsPageEditArguments(teamId: event.teamId),
    );

    yield TeamsStateWaiting();
    final response = await service.getTeam(event.teamId);
    if (response.status == ApiResponseStatuses.success) {
      yield TeamsStateViewing(team: response.team);
    } else {
      // Error handling must be here!!
    }
  }
}
