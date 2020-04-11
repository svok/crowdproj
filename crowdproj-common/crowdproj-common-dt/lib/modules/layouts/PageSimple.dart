import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageSimple extends StatelessWidget {
  PageSimple({
    Key key,
    @required this.title,
    @required this.body,
    this.floatingActionButton,
    this.appBarBottom,
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
  final Widget body;
  final Widget appBarBottom;
  final List<Widget> actions;
  final Widget floatingActionButton;
  final Widget menu;

  @override
  Widget build(BuildContext context) {
//    AppSession.get.routes.setWindow(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: actions,
          bottom: appBarBottom,
        ),
        drawer: menu,
        body: body,
        floatingActionButton: floatingActionButton,
    );
  }
}
