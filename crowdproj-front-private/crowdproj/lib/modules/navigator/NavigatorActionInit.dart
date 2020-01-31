import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionHome.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionPromo.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionInit extends NavigatorAction {

  @override
  Object get arguments => null;

  @override
  get builder => null;

  @override
  String get path => null;

  @override
  Future<NavigatorAction> go(NavigatorState navigatorState) async {
    final _securePrefs = AppSession.get.securePrefs;
    final isPromoShown =
        _securePrefs.getString(key_promo_shown, defaultValue: "false") ==
            "true";

    if (!isPromoShown) {
      await _securePrefs.setString(key_promo_shown, "true");
      return NavigatorActionPromo();
    } else {
      return NavigatorActionHome();
    }
  }

  static const key_promo_shown = "promo_shown";
}
