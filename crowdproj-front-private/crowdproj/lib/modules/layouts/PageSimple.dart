import 'package:crowdproj/common/AppSession.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/widgets/menu/MenuWidget.dart';

class PageSimple extends StatelessWidget {
  PageSimple({
    Key key,
    @required String this.title,
    @required Widget this.body,
    Widget this.floatingActionButton,
    Widget this.appBarBottom,
  }) : super(key: key);

  final String title;
  final Widget body;
  final Widget appBarBottom;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
//    AppSession.get.routes.setWindow(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: appBarBottom,
        ),
        drawer: MenuWidget(),
        body: body,
        floatingActionButton: floatingActionButton,
    );
  }
}
