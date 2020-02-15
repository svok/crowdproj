import 'package:flutter/material.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/auth/ProfileWidget.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';
import 'package:crowdproj/widgets/CentralContainerWidget.dart';

import 'AuthPage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _PofilePageState createState() => new _PofilePageState();

  static final RouteDescription route = RouteDescription(
      id: "ProfilePage",
      pathFormatter: ({dynamic arguments}) =>
          "${AuthPage.route.pathFormatted(arguments: arguments)}/profile",
      titleFormatter: ({BuildContext context, dynamic arguments}) =>
          AuthLocalizations.of(context).titleUpdate,
      builder: (BuildContext context) {
        return ProfilePage();
      });
}

class _PofilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final localizer = AuthLocalizations.of(context);
    return PageSimple(
      title: localizer.titleUpdate,
      body: CentralContainerWidget(
        child: ProfileWidget(
          onUserUpdatedCallback: () {
            final navigator = Navigator.of(context);
            if (navigator == null) return;
            if (navigator.canPop()) navigator.pop();
          },
        ),
      ),
    );
  }
}
