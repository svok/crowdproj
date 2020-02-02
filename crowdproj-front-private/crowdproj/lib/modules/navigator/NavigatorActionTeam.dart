import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/teams/TeamPage.dart';

import 'NavigatorActionDefaultAbstarct.dart';

class NavigatorActionTeam extends NavigatorActionDefaultAbstract {
  NavigatorActionTeam({
    this.teamId,
  }) : super();
  String teamId;

  @override
  RouteDescription get route=> TeamPage.route;

  @override
  TeamsPageEditArguments get arguments =>
      TeamsPageEditArguments(teamId: teamId);
}
