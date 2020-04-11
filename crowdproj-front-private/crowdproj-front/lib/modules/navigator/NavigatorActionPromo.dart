import 'package:crowdproj/modules/navigator/NavigatorActionDefaultAbstarct.dart';
import 'package:crowdproj/modules/promo/PromoPage.dart';
import 'package:crowdproj_common/common/RouteDescription.dart';

import 'NavigatorAction.dart';

class NavigatorActionPromo extends NavigatorActionDefaultAbstract {
  @override
  RouteDescription get route=> PromoPage.route;

  @override
  AccessResult get hasAccess => AccessResult.allowed;

  @override
  List<Object> get props => [];

}
