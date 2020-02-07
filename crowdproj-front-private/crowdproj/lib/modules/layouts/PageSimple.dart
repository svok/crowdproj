import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/auth/AuthService.dart';
import 'package:crowdproj/modules/auth/widgets/MenuUserHead.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/widgets/menu/MenuWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PageSimple extends StatelessWidget {
  PageSimple({
    Key key,
    @required String this.title,
    @required Widget this.body,
    Widget this.floatingActionButton,
  }) : super(key: key);

  final String title;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
//    AppSession.get.routes.setWindow(context);
    final _auth = AppSession.get.authService;
    return Scaffold(
        appBar: MenuWidget(
          title: title,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              MenuUserHead(),
              Consumer<AuthService>(builder: (context, _auth, child) {
                print("PAGE SIMPLE: ${_auth.runtimeType} -- ${child?.runtimeType}");
                final _user = _auth.currentUser;
                if (!_auth.isAuthenticated() || _user == null)
                  return Container();
                return ListTile(
                    leading: Icon(FontAwesomeIcons.signOutAlt),
                    title:
                        new Text(AuthLocalizations.of(context).signoutFor("")),
                    onTap: () {
                      Navigator.of(context).pop();
                      _auth.signOut();
                    });
              }),
            ],
          ),
          semanticLabel: "Semantic Label",
        ),
        body: body,
        floatingActionButton: floatingActionButton);
  }
}
