import 'package:crowdproj/modules/about/AboutPage.dart';
import 'package:crowdproj_common/common/RouteDescription.dart';

import 'NavigatorActionDefaultAbstarct.dart';

class NavigatorActionAbout extends NavigatorActionDefaultAbstract {
  @override
  RouteDescription get route=> AboutPage.route;

  @override
  List<Object> get props => [];
}
