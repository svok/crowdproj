import 'package:flutter/material.dart';

class PageSimpleWithTabs extends StatelessWidget {
  PageSimpleWithTabs({
    Key key,
    @required String this.title,
    @required this.bodies,
    Widget this.floatingActionButton,
    @required List<Widget> this.tabButtons,
    this.onTabSelected,
    this.bottomNavBar,
    this.menu,
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
  final Widget menu;

  @override
  Widget build(BuildContext context) {
//    AppSession.get.routes.setWindow(context);
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
//        drawer: MenuWidget(),
        drawer: menu,
        body: TabBarView(
          children: bodies,
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }
}
