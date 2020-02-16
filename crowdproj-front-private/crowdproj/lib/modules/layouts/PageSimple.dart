import 'package:crowdproj/common/AppSession.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/widgets/menu/MenuWidget.dart';

class PageSimple extends StatelessWidget {
  PageSimple({
    Key key,
    @required this.title,
    @required this.body,
    this.floatingActionButton,
    this.appBarBottom,
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

  @override
  Widget build(BuildContext context) {
//    AppSession.get.routes.setWindow(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: actions,
          bottom: appBarBottom,
        ),
        drawer: MenuWidget(),
        body: body,
        floatingActionButton: floatingActionButton,
    );
  }
}
