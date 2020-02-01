import 'package:flutter/material.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/about/MenuItemAbout.dart';
import 'package:crowdproj/modules/auth/widgets/MenuItemProfile.dart';
import 'package:crowdproj/modules/auth/widgets/MenuItemSignOut.dart';
import 'package:crowdproj/modules/teams/MenuItemTeams.dart';

class MenuWidget extends StatefulWidget implements PreferredSizeWidget {
  MenuWidget({
    Key key,
    this.title,
  }) : super(key: key) {
    final bottom = null;
    preferredSize = Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));
  }

  final String title;

  @override
  State<StatefulWidget> createState() => _MenuWidgetState();

  @override
  Size preferredSize;
}

class _MenuWidgetState extends State<MenuWidget> {
//  @override
//  didChangeDependencies() {
//    super.didChangeDependencies();
//    AppSession.get.routes.redirectTo(context: context);
//  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        new PopupMenuButton(
          onSelected: (String valueSelected) async {
            print("MenuItem $valueSelected");
            switch (valueSelected) {
              case MenuItemTeams.id:
                await MenuItemTeams.callback(context);
                break;
              case MenuItemSignOut.id:
                await MenuItemSignOut.callback(context);
                break;
              case MenuItemProfile.id:
                await MenuItemProfile.callback(context);
                break;
              case MenuItemAbout.id:
                await MenuItemAbout.callback(context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            MenuItemTeams(context: context),
            MenuItemAbout(context: context),
            MenuItemProfile(context: context),
            const PopupMenuDivider(),
            MenuItemSignOut(context: context),
          ],
        ),
      ],
    );
  }
}
