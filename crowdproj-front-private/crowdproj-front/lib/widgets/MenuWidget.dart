import 'package:crowdproj/modules/auth/widgets/MenuItemProfile.dart';
import 'package:crowdproj/modules/auth/widgets/MenuItemSignOut.dart';
import 'package:crowdproj/modules/auth/widgets/MenuUserHead.dart';
import 'package:crowdproj_teams/TeamsModule.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/modules/about/MenuItemAbout.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scrollbar(
        child: ListView(
          children: <Widget>[]
            ..add(MenuUserHead())
            ..add(MenuItemAbout())
            ..addAll(TeamsModule().menuItems())
            ..add(MenuItemProfile())
            ..add(Divider())
            ..add(MenuItemSignOut())
        ),
      ),
      semanticLabel: "Semantic Label",
    );
  }
}
