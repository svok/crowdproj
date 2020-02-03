import 'dart:async';
import 'package:bloc/bloc.dart';
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
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamsBloc - Error\'s occured: $error, $stackTrace');
  }

}
