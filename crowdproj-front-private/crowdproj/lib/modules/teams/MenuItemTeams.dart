import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/modules/teams/TeamsPage.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';

class MenuItemTeams extends PopupMenuItem<String> {
  MenuItemTeams({Key key, bool enabled = true, @required BuildContext context})
      : super(
          key: key,
          value: id,
          enabled: enabled,
          child: Text(TeamsLocalizations.of(context).title),
        );
  static const String id = "teams";

  static callback(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (navigator == null) return;
    if (navigator.canPop()) navigator.pop();
    navigator.pushNamed(TeamsPage.route.pathFormatted());
  }
}
