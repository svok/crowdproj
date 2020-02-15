import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/modules/team/update/TeamUpdateEvent.dart';

class TeamUpdateEventRead extends TeamUpdateEvent {
  TeamUpdateEventRead({
    this.teamId,
    this.team,
  }) : super();
  final String teamId;
  final Team team;
}
