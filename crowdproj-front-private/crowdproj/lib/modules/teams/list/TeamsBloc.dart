import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:flutter/material.dart';

import 'TeamsEvent.dart';
import 'TeamsState.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc({
    @required this.context,
  }) : super();

  final BuildContext context;
  static const BATCH_SIZE = 20;

  @override
  TeamsState get initialState => TeamsState();

  @override
  Stream<TeamsState> mapEventToState(TeamsEvent event) async* {
    switch(event) {
      case TeamsEvent.init: yield* _init(); break;
      case TeamsEvent.readNext: yield* _readNext(); break;
      case TeamsEvent.update: yield* _update(); break;
      default: yield TeamsState();
    }
    print("TEAMS BLOC EVENT: $event");
  }

  Stream<TeamsState> _init() async* {
    final query = TeamsQuery(
      offset: 0,
      limit: BATCH_SIZE,
    );
    yield TeamsState(
      query: query,
      teams: [],
      errors: [],
      isWaiting: true,
    );
    final result = await AppSession.get.teamsService.getTeams(query);
    yield TeamsState(
      query: query,
      teams: result.teams,
      errors: result.errors,
      hasReachedMax: result.teams.length < query.limit,
    );
  }

  Stream<TeamsState> _readNext() async* {
    yield state.clone(isWaiting: true);

    final query = TeamsQuery(
      onDate: state.timeVersion,
      offset: state.offset + state.limit,
      limit: BATCH_SIZE,
    );
    final result = await AppSession.get.teamsService.getTeams(query);
    final newTeams = (state?.teams ?? []) + (result?.teams ?? []);
    yield TeamsState(
      query: query,
      teams: newTeams,
      errors: result.errors,
      hasReachedMax: result.teams.length < query.limit,
    );
  }

  Stream<TeamsState> _update() async* {
    yield state.clone(isWaiting: true);

    final query = TeamsQuery(
      offset: 0,
      limit: state.teams?.length,
    );
    final _service = AppSession.get.teamsService;
    final result = await _service.getTeams(query);
    final newTeams = result?.teams ?? [];
    _service.isUptodate = true;
    yield TeamsState(
      query: query,
      teams: newTeams,
      errors: result.errors,
      hasReachedMax: result.teams.length < query.limit,
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamsBloc - Error\'s occured: $error, $stackTrace');
  }

}
