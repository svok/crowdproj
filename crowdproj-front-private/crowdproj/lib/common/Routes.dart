
import 'package:crowdproj/modules/teams/TeamsPageEdit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:crypted_preferences/crypted_preferences.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/about/AboutPage.dart';
import 'package:crowdproj/modules/auth/AuthPage.dart';
import 'package:crowdproj/modules/auth/ProfilePage.dart';
import 'package:crowdproj/modules/error/ErrorPageArgs.dart';
import 'package:crowdproj/modules/home/HomePage.dart';
import 'package:crowdproj/modules/platforms/AppPlatform.dart';
import 'package:crowdproj/modules/promo/PromoPage.dart';
import 'package:crowdproj/modules/teams/TeamsPage.dart';

import '../modules/error/ErrorPage.dart';
import 'StatedRouteDescription.dart';

typedef Widget CpWidgetBuilder();

class Routes {

  static const key_promo_shown = "promo_shown";

  static final openRoutes = [AuthPage.route.pathFormatted(), PromoPage.route.pathFormatted()];

  static final widgets = [
    HomePage.route,
    PromoPage.route,
    AboutPage.route,
    AuthPage.route,
    ProfilePage.route,
    TeamsPage.route,
    TeamsPageEdit.route,
    ErrorPage.route,
  ];

  StatedRouteDescription _currentRoute;
  StatedRouteDescription get currentRoute => _currentRoute;
  bool _updateCurrentRoute(RouteDescription route, RouteSettings settings) {
    final newState = StatedRouteDescription(route: route, settings: settings);
    if (newState != _currentRoute) {
      _currentRoute = newState;
      return true;
    } else {
      return false;
    }
  }

  RouteDescription findRoute(RouteSettings settings) => widgets.firstWhere((e) => settings?.name == e.pathFormatted(settings: settings), orElse: () => ErrorPage.route);

  setWindow(BuildContext context) {
    final homePageTitle = HomePage.route.titleFormatted(context: context);
    final pageName = currentRoute?.title(context: context);
    final pagePath = currentRoute?.path();
    final title =
        pageName == null ? homePageTitle : "${pageName} - $homePageTitle";
//    AppPlatform.configWindow("", title, pagePath);
  }
}
