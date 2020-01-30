
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

  Preferences _securePrefs;

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

  Routes(Preferences prefs) {
    _securePrefs = prefs;
  }

  RouteDescription findRoute(RouteSettings settings) => widgets.firstWhere((e) => settings?.name == e.pathFormatted(settings: settings), orElse: () => ErrorPage.route);

  Route<dynamic> routeTo(RouteSettings settings) {
    final widgetRoute = findRoute(settings);
    if (widgetRoute != null) {
      final route =
          MaterialPageRoute(builder: widgetRoute.builder, settings: settings);
      _updateCurrentRoute(widgetRoute, settings);
      return route;
    }
    return routeTo(RouteSettings(arguments: ErrorPageArgs(code: 404, badRoute: settings)));
  }

  void redirectTo({BuildContext context}) {
    final currentRouteObj = ModalRoute.of(context);
    if (!currentRouteObj.isCurrent) return;
    final currentRoute = currentRouteObj.settings.name;
    String route = currentRoute;
    route = _routeToPromo(route);
    route = _routeToAuth(route);

    // If route is not changed we just go out with no action
    if (currentRoute == route) return;

    final navigator = Navigator.of(context);
    if (navigator == null) return;
    final settings = RouteSettings(name: route);
    final widgetRoute = findRoute(settings);
    if (widgetRoute != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (!_updateCurrentRoute(widgetRoute, settings)) return;
        final routeObj = MaterialPageRoute(
            builder: widgetRoute.builder, settings: settings);
//        if (routeObj == _currentRoute) return;
        if (navigator.canPop() == true) navigator.pop();
        navigator.push(routeObj);
      });
    }
  }

  String _routeToPromo(String route) {
    if (route != HomePage.route.pathFormatted(settings: RouteSettings(name: route))) return route;
    final isPromoShown =
        _securePrefs.getString(key_promo_shown, defaultValue: "false") ==
            "true";
    if (!isPromoShown) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        await _securePrefs.setString(key_promo_shown, "true");
      });
      return PromoPage.route.pathFormatted();
    }
    return route;
  }

  String _routeToAuth(String route) {
    final isAuthorized = AppSession.get.authService.isAuthenticated();
    final isOpen = openRoutes.contains(route);
    final newRoute = !isAuthorized && !isOpen ? AuthPage.route.pathFormatted() : route;
    return newRoute;
  }

  setWindow(BuildContext context) {
    final homePageTitle = HomePage.route.titleFormatted(context: context);
    final pageName = currentRoute?.title(context: context);
    final pagePath = currentRoute?.path();
    final title =
        pageName == null ? homePageTitle : "${pageName} - $homePageTitle";
    AppPlatform.configWindow("", title, pagePath);
  }
}
