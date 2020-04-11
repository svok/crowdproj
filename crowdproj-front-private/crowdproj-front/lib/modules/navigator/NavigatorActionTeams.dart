import 'package:crowdproj/modules/navigator/NavigatorActionDefaultAbstarct.dart';
import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:crowdproj_teams/lists/TeamsPage.dart';

class NavigatorActionTeams extends NavigatorActionDefaultAbstract {
  @override
  RouteDescription get route=> TeamsPage.route;

  @override
  List<Object> get props => [];
}
