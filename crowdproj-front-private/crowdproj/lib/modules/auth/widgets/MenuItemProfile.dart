
import 'package:flutter/material.dart';
import 'package:crowdproj/modules/auth/ProfilePage.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';

class MenuItemProfile extends PopupMenuItem<String> {
  MenuItemProfile({Key key, bool enabled = true, @required BuildContext context})
      : super(
    key: key,
    value: id,
    enabled: enabled,
//  this.height = kMinInteractiveDimension,
//  this.textStyle,
    child: Text(AuthLocalizations.of(context).titleUpdate),
  );

  static const String id = "profile";
  static callback(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (navigator == null) return;
    if (navigator.canPop()) navigator.pop();
    navigator.pushNamed(ProfilePage.route.pathFormatted());
  }

}
