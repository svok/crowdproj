import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/about/AboutPage.dart';

import 'NavigatorActionDefaultAbstarct.dart';

class NavigatorActionAbout extends NavigatorActionDefaultAbstract {
  @override
  RouteDescription get route=> AboutPage.route;

  @override
  List<Object> get props => [];
}
