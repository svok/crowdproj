import 'package:crowdproj/translations/AuthLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../AuthService.dart';

class MenuItemSignOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, _auth, child) {
      final _user = _auth.currentUser;
      if (!_auth.isAuthenticated() || _user == null) return Container();
      return ListTile(
          trailing: Icon(FontAwesomeIcons.signOutAlt),
          title: new Text(AuthLocalizations.of(context).signoutFor("")),
          onTap: () {
            Navigator.of(context).pop();
            _auth.signOut();
          });
    });
  }
}
