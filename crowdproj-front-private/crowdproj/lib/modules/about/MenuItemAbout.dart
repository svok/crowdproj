import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/modules/about/AboutPage.dart';
import 'package:crowdproj/translations/HomeLocalizations.dart';

class MenuItemAbout extends PopupMenuItem<String> {
  MenuItemAbout({Key key, bool enabled = true, @required BuildContext context})
      : super(
          key: key,
          value: id,
          enabled: enabled,
          child: Text(HomeLocalizations.of(context).titleAbout),
        );
  static const String id = "about";

  static callback(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (navigator == null) return;
    if (navigator.canPop()) navigator.pop();
    navigator.pushNamed(AboutPage.route.pathFormatted());
  }
}
