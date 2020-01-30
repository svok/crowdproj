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
//    this.navigatorKey,
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

//  CrowdprojModels crowdprojApi;
//
//  final _teamsStream = rxdart.BehaviorSubject<Teams>();
//  Stream<Teams> get teams => _teamsStream.stream;
//
//  //constructor
//  TeamsBloc(this.crowdprojApi) {
//    initialise();
//  }
//
//  void initialise() async {
//    await getCounter();
//  }
//
//  void dispose() {
//    _teamsStream.close();
//  }
//
//  getCounter() async {
//    _counter = await client.counterServiceApi.getCounter();
//    if (_counter == null) {
//      _counter = new Counter()..amount = 0;
//    }
//    _teamsStream.add(_counter);
//  }
//
//  counterInc() async {
//    Counter cnt = new Counter()..amount = 1;
//    _counter = await client.counterServiceApi.incCounter(cnt);
//    _teamsStream.add(_counter);
//  }
//
//  counterReset() async {
//    _counter = await client.counterServiceApi.resetCounter();
//    _teamsStream.add(_counter);
//  }
}
