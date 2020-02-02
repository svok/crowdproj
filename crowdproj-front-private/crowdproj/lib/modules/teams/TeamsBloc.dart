import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:flutter/material.dart';

import 'events/TeamsEvent.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc({
    @required this.navigatorKey,
  }) : super();

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  TeamsState get initialState => TeamsStateNothing();

  @override
  Stream<TeamsState> mapEventToState(TeamsEvent event) async* {
    yield* event.handle(navigatorKey.currentContext);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamsBloc - Error\'s occured: $error, $stackTrace');
  }

}
