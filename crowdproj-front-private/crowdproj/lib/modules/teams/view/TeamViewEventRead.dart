import 'package:crowdproj/api/models/Team.dart';

import 'TeamViewEvent.dart';

class TeamViewEventRead extends TeamViewEvent{
  TeamViewEventRead({
    this.teamId,
    this.team,
  }) : super();
  final String teamId;
  final Team team;
}
