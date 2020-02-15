import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/modules/team/view/TeamViewEvent.dart';

class TeamViewEventRead extends TeamViewEvent{
  TeamViewEventRead({
    this.teamId,
    this.team,
  }) : super();
  final String teamId;
  final Team team;
}
