import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:flutter/material.dart';

abstract class TeamsEvent {

  Stream<TeamsState> handle(BuildContext context);
}
