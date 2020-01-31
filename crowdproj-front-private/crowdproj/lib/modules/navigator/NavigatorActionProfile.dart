import 'package:crowdproj/modules/auth/ProfilePage.dart';
import 'package:flutter/material.dart';

import 'NavigatorAction.dart';

class NavigatorActionProfile extends NavigatorAction {
  NavigatorActionProfile(BuildContext context, {
    this.teamId,
  }) : super(context);
  String teamId;

  final _route = ProfilePage.route;

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
