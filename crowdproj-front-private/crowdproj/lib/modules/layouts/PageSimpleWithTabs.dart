import 'package:crowdproj/common/AppSession.dart';
import 'package:flutter/cupertino.dart';
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
  }) : super(key: key);

  final String title;
  final List<Widget> bodies;
  final Widget floatingActionButton;
  final List<Widget> tabButtons;
  final ValueChanged<int> onTabSelected;

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
        ),
        drawer: MenuWidget(),
        body: TabBarView(
          children: bodies,
        ),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
