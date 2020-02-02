import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/teams/TeamsPageEdit.dart';

import 'NavigatorActionDefaultAbstarct.dart';

class NavigatorActionTeamsEdit extends NavigatorActionDefaultAbstract {
  NavigatorActionTeamsEdit({
    this.teamId,
  }) : super();
  String teamId;

  @override
  RouteDescription get route=> TeamsPageEdit.route;

  @override
  TeamsPageEditArguments get arguments =>
      TeamsPageEditArguments(teamId: teamId);
}
