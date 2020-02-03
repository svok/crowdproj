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

  @override
  TeamsState get initialState => TeamsState();

  @override
  Stream<TeamsState> mapEventToState(TeamsEvent event) async* {
    switch(event) {
      case TeamsEvent.init: yield* _init(); break;
      default: yield TeamsState();
    }
    print("TEAMS BLOC EVENT: $event");
  }

  Stream<TeamsState> _init() async* {
    final query = TeamsQuery(
      offset: 0,
      limit: 4,
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
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamsBloc - Error\'s occured: $error, $stackTrace');
  }

}
