import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:flutter/material.dart';

import 'events/TeamEvent.dart';

class TeamBloc extends Bloc<TeamEvent, TeamsState> {
  TeamBloc({
    @required this.context,
  }) : super();

  final BuildContext context;

  @override
  TeamsState get initialState => TeamsStateNothing();

  @override
  Stream<TeamsState> mapEventToState(TeamEvent event) async* {
    yield* event.handle(this);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamBloc - Error\'s occured: $error, $stackTrace');
  }

}
