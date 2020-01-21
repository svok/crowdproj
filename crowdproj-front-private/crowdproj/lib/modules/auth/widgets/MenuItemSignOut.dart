import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';

class MenuItemSignOut extends PopupMenuItem<String> {
  MenuItemSignOut({Key key, bool enabled = true, @required BuildContext context})
      : super(
          key: key,
          value: id,
          enabled: enabled,
//  this.height = kMinInteractiveDimension,
//  this.textStyle,
          child: Text(AuthLocalizations.of(context)
              .signoutFor(AppSession.get.authService.currentUser?.name ?? "--")),
        );
  static const String id = "signuot";
  static callback(BuildContext context) async {
    await AppSession.get.authService.signOut();
  }
}
