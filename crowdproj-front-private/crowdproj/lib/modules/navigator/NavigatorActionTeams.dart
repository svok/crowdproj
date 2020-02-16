import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionDefaultAbstarct.dart';
import 'package:crowdproj/modules/teams/list/TeamsPage.dart';

class NavigatorActionTeams extends NavigatorActionDefaultAbstract {
  @override
  RouteDescription get route=> TeamsPage.route;

  @override
  List<Object> get props => [];
}
