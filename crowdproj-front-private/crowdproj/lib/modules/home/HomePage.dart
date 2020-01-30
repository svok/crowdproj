import 'package:crowdproj/modules/navigator/NavigatorAction.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/common/RouteSettingsArgs.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/translations/HomeLocalizations.dart';
import 'package:crowdproj/widgets/GridWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/AuthPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  static String titleFormatter(
          {BuildContext context, RouteSettings settings}) =>
      HomeLocalizations.of(context).title;

  static String pathFormatter({RouteSettings settings}) =>
      "/";

  static final route = RouteDescription(
      id: "HomePage",
      pathFormatter: HomePage.pathFormatter,
      titleFormatter: HomePage.titleFormatter,
      builder: (BuildContext context) {
        return HomePage();
      });
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizer = HomeLocalizations.of(context);
    return PageSimple(
      title: localizer.title,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4.0),
            child: FloatingActionButton(
              heroTag: "main-increment",
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: FloatingActionButton(
              heroTag: "main-login",
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new AuthPage()),
                );
              },
              child: Icon(Icons.navigate_next),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: FloatingActionButton(
              onPressed: () {
                final teamsBloc = BlocProvider.of<TeamsBloc>(context);
                final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
                print("NAVIGATOR is requested for EditPage");
                navigatorBloc.add(NavigatorActionTeamsEdit(
                    Navigator.of(context),
                ));
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => GridWidget()),
//                );
              },
              heroTag: "teamEdit",
              tooltip: 'Update Team',
              child: Icon(Icons.group),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
