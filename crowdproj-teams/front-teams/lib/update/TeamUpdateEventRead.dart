
import 'package:crowdproj_teams_models/models/Team.dart';

import 'TeamUpdateEvent.dart';

class TeamUpdateEventRead extends TeamUpdateEvent {
  TeamUpdateEventRead({
    this.teamId,
    this.team,
  }) : super();
  final String teamId;
  final Team team;
}
