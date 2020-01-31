import 'package:crowdproj/modules/about/AboutPage.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionAbout extends NavigatorAction {
  NavigatorActionAbout(BuildContext context, {
    this.teamId,
  }) : super(context);
  String teamId;

  final _route = AboutPage.route;

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

}
