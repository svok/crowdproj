import 'package:crowdproj/modules/home/HomePage.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionDefaultAbstarct.dart';
import 'package:crowdproj_common/common/RouteDescription.dart';

class NavigatorActionHome extends NavigatorActionDefaultAbstract {
  @override
  RouteDescription get route=> HomePage.route;

  @override
  List<Object> get props => [];

}
