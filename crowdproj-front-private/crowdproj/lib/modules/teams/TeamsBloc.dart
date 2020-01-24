import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/modules/teams/TeamsEvent.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj_models/api/team_api.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc({@required this.api}) : super();
  TeamApi api;

  @override
  TeamsState get initialState => TeamsState();

  @override
  Stream<TeamsState> mapEventToState(TeamsEvent event) async* {
    final res = await api.findTeamsByTags(["tags"]);
    yield TeamsState();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamsBloc - Error\'s occured: $error, $stackTrace');
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
