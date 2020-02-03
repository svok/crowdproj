import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/team/TeamPage.dart';
import 'package:crowdproj/modules/team/TeamPageArguments.dart';

import 'NavigatorActionDefaultAbstarct.dart';

class NavigatorActionTeam extends NavigatorActionDefaultAbstract {
  NavigatorActionTeam({
    this.teamId,
    this.team,
  }) : super();
  final Team team;
  final String teamId;

  @override
  RouteDescription get route => TeamPage.route;

  @override
  TeamPageArguments get arguments =>
      TeamPageArguments(teamId: teamId, team: team);

  @override
  List<Object> get props => [team, teamId];
}
