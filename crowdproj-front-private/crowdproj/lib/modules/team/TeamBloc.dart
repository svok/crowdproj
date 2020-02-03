import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'events/TeamEvent.dart';
import 'states/TeamState.dart';
import 'states/TeamStateNothing.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  TeamBloc({
    @required this.context,
  }) : super();

  final BuildContext context;

  @override
  TeamState get initialState => TeamStateNothing();

  @override
  Stream<TeamState> mapEventToState(TeamEvent event) async* {
    yield* event.handle(this);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamBloc - Error\'s occured: $error, $stackTrace');
  }

}
