import 'package:crowdproj/api/models/Team.dart';

class TeamPageArguments {
  TeamPageArguments({
    this.teamId,
    this.team,
  }) : super();

  Team team;
  String teamId;
}
