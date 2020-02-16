import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/widgets/menu/MenuWidget.dart';

class PageSimpleWithTabs extends StatelessWidget {
  PageSimpleWithTabs({
    Key key,
    @required String this.title,
    @required this.bodies,
    Widget this.floatingActionButton,
    @required List<Widget> this.tabButtons,
    this.onTabSelected,
    this.bottomNavBar,
    List<Widget> actions,
  }) : this.actions = actions ?? [
    Builder(builder: (context) => Navigator.of(context).canPop() ? IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).maybePop();
        }) : Container(),
    ),
  ], super(key: key);

  final String title;
  final List<Widget> bodies;
  final Widget floatingActionButton;
  final List<Widget> tabButtons;
  final ValueChanged<int> onTabSelected;
  final Widget bottomNavBar;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
//    AppSession.get.routes.setWindow(context);
    final localizer = TeamsLocalizations.of(context);
    return DefaultTabController(
      length: tabButtons.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            tabs: tabButtons,
            onTap: onTabSelected,
          ),
          actions: actions,
        ),
        drawer: MenuWidget(),
        body: TabBarView(
          children: bodies,
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }
}
