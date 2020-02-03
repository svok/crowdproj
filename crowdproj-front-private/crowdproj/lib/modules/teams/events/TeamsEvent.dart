import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:flutter/material.dart';

abstract class TeamsEvent {

  Stream<TeamsState> handle(TeamsBloc teamsBloc);
}
