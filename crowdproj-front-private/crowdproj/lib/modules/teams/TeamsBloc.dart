import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/modules/teams/TeamsEvent.dart';
import 'package:crowdproj/modules/teams/TeamsService.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import 'models/Team.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc({
    @required this.service,
  }) : super();

  final TeamsService service;

  @override
  TeamsState get initialState => TeamsStateNothing();

  @override
  Stream<TeamsState> mapEventToState(TeamsEvent event) async* {
    switch (event.runtimeType) {
      case TeamsEventSaveRequested:
        yield* _saveEvent(event as TeamsEventSaveRequested);
        break;
      case TeamsEventEditRequested:
        yield* _editEvent(event as TeamsEventEditRequested);
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
    final response = service.saveTeam(event.team);
    yield TeamsStateViewing(team: event.team);
  }

  Stream<TeamsState> _editEvent(TeamsEventEditRequested event) async* {
    if (event.team == null) {
      yield TeamsStateEditing(team: Team(), teamEdited: Team());
    } else {
      yield TeamsStateWaiting();
      final response = service.getTeam(event.team);
      yield TeamsStateEditing(team: event.team, teamEdited: );
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
