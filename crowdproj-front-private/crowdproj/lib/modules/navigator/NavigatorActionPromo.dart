import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionDefaultAbstarct.dart';
import 'package:crowdproj/modules/promo/PromoPage.dart';

import 'NavigatorAction.dart';

class NavigatorActionPromo extends NavigatorActionDefaultAbstract {
  @override
  RouteDescription get route=> PromoPage.route;

  @override
  AccessResult get hasAccess => AccessResult.allowed;

}
