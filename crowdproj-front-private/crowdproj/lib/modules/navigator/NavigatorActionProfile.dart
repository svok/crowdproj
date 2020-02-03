import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/auth/ProfilePage.dart';

import 'NavigatorActionDefaultAbstarct.dart';

class NavigatorActionProfile extends NavigatorActionDefaultAbstract {
  @override
  RouteDescription get route=> ProfilePage.route;

  @override
  List<Object> get props => [];

}
