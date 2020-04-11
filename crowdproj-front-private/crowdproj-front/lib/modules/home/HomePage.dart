import 'package:crowdproj/modules/navigator/NavigatorActionTeams.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:crowdproj/widgets/MenuWidget.dart';
import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:crowdproj_common/modules/layouts/PageSimple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/HomeLocalizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  static final RouteDescription route = RouteDescription(
      id: "HomePage",
      pathFormatter: ({dynamic arguments}) => "/",
      titleFormatter: ({BuildContext context, dynamic arguments}) =>
          HomeLocalizations.of(context).title,
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
              heroTag: "main-teams",
              onPressed: () {
                BlocProvider.of<NavigatorBloc>(context)
                    .add(NavigatorActionTeams());
              },
              child: Icon(Icons.group),
            ),
          ),
        ],
      ), //
      menu: MenuWidget(),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
