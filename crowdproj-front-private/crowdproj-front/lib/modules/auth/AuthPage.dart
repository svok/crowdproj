import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/modules/auth/ConfirmWidget.dart';
import 'package:crowdproj/modules/auth/SignupWidget.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'SigninWidget.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => new _AuthPageState();

  static final RouteDescription route = RouteDescription(
      id: "AuthPage",
      pathFormatter: ({dynamic arguments}) => "/user",
      titleFormatter: ({BuildContext context, dynamic arguments}) =>
          AuthLocalizations.of(context).title,
      builder: (BuildContext context) {
        return AuthPage();
      });
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  int _tab = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizer = AuthLocalizations.of(context);
//    AppSession.get.routes.setWindow(context);
    return DefaultTabController(
      initialIndex: _tab,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorPadding: EdgeInsets.all(10),
            tabs: [
              Tab(
                text: localizer.titleLogin,
                icon: Icon(FontAwesomeIcons.signInAlt),
              ),
              Tab(
                text: localizer.titleRegister,
                icon: Icon(FontAwesomeIcons.userPlus),
              ),
              Tab(
                  text: localizer.titleConfirm,
                  icon: Icon(Icons.confirmation_number)),
            ],
          ),
          title: Text(localizer.title),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SigninWidget(
              onSignediInCallback: () {
//                SchedulerBinding.instance.addPostFrameCallback((_){
//                  final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
//                  navigatorBloc.add(NavigatorActionAuthDone());
//                });
                return Container();
              },
              onUnconfirmedCallback: () {
                _tabController?.index = tabConfirm;
              },
            ),
            SignupWidget(
              onUnconfirmedCallback: () {
                _tabController?.index = tabConfirm;
              },
            ),
            ConfirmWidget(
              onAccountConfirmed: () {
                _tabController?.index = tabSignin;
              },
            ),
          ],
        ),
      ),
    );
  }

  static const int tabSignin = 0;
  static const int tabSignup = 1;
  static const int tabConfirm = 2;
}
