import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/team/TeamPageArguments.dart';
import 'package:crowdproj/modules/team/view/TeamViewPage.dart';

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
