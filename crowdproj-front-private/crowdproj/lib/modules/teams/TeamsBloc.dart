import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:flutter/material.dart';

import 'TeamsEvent.dart';

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
    final query = TeamsQuery(
      onDate: state.timeVersion,
      offset: state.offset + state.limit,
      limit: BATCH_SIZE,
    );
    yield state.clone(isWaiting: true);
    final result = await AppSession.get.teamsService.getTeams(query);
    final newTeams = (state?.teams ?? []) + (result?.teams ?? []);
    print("FETCH result: ${result.teams?.length ?? 0} - total: ${newTeams.length}");
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
