import 'package:crowdproj_teams_models/models/Team.dart';

class TeamPageArguments {
  TeamPageArguments({
    this.teamId,
    this.team,
  }) : super();

  Team team;
  String teamId;
}
