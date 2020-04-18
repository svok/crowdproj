import 'package:crowdproj/modules/auth/ProfilePage.dart';
import 'package:crowdproj_common/common/RouteDescription.dart';

import 'NavigatorActionDefaultAbstarct.dart';

class NavigatorActionProfile extends NavigatorActionDefaultAbstract {
  @override
  RouteDescription get route=> ProfilePage.route;

  @override
  List<Object> get props => [];

}
