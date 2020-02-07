import 'package:crowdproj/common/AppSession.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AuthService.dart';

class MenuUserHead extends StatefulWidget {
  @override
  _MenuUserHeadState createState() => _MenuUserHeadState();
}

class _MenuUserHeadState extends State<MenuUserHead> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, _auth, child) {
      final _user = _auth.currentUser;
      if (!_auth.isAuthenticated() || _user == null) return Container();
      return UserAccountsDrawerHeader(
        accountName: Text(_user.name),
        accountEmail: Text(_user.email),
        currentAccountPicture: CircleAvatar(
          backgroundColor:
          Theme
              .of(context)
              .platform == TargetPlatform.iOS
              ? Colors.blue
              : Colors.white,
          child: Text(
            "A",
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      );
    });
  }

}
