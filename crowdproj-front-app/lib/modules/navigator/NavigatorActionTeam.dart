
import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:crowdproj_teams/TeamPageArguments.dart';
import 'package:crowdproj_teams/view/TeamViewPage.dart';
import 'package:crowdproj_teams_models/models/Team.dart';

import 'NavigatorActionDefaultAbstarct.dart';

class NavigatorActionTeam extends NavigatorActionDefaultAbstract {
  NavigatorActionTeam({
    this.teamId,
    this.team,
  }) : super();
  final Team team;
  final String teamId;

  @override
  RouteDescription get route => TeamViewPage.route;

  @override
  TeamPageArguments get arguments =>
      TeamPageArguments(teamId: teamId, team: team);

  @override
  List<Object> get props => [team, teamId];
}
