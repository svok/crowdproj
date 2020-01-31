import 'package:crowdproj/modules/promo/PromoPage.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionPromo extends NavigatorAction {
  final _route = PromoPage.route;

  @override
  String get path {
    return _route.pathFormatted(
      settings: RouteSettings(
        name: _route.pathName,
        arguments: arguments,
      ),
    );
  }

  @override
  WidgetBuilder get builder => _route.builder;

  @override
  Object get arguments => null;

  @override
  AccessResult get hasAccess => AccessResult.allowed;

}
