import 'package:crowdproj/modules/auth/widgets/MenuItemProfile.dart';
import 'package:crowdproj/modules/auth/widgets/MenuItemSignOut.dart';
import 'package:crowdproj/modules/auth/widgets/MenuUserHead.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/modules/about/MenuItemAbout.dart';
import 'package:crowdproj/modules/teams/list/MenuItemTeams.dart';

class MenuWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          MenuUserHead(),
          MenuItemAbout(),
          MenuItemTeams(),
          MenuItemProfile(),
//              SizedBox(
//                height: 200,
//              ),
          Divider(),
          MenuItemSignOut(),
        ],
      ),
      semanticLabel: "Semantic Label",
    );
  }
}
