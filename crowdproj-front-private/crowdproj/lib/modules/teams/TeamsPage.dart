import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionTeam.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsEvent.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/models/Team.dart';
import 'TeamsPageArgs.dart';
import 'TeamsWidget.dart';

class TeamsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsPageState();

  final team = Team();

  static final RouteDescription<TeamsPageArgs> route = RouteDescription(
      id: "TeamsPage",
      pathName: "/teams",
      pathFormatter: ({TeamsPageArgs arguments}) => "/teams",
      titleFormatter: ({BuildContext context, TeamsPageArgs arguments}) =>
          TeamsLocalizations.of(context).title,
      builder: (BuildContext context) {
        return TeamsPage();
      });
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return PageSimple(
      title: localizer.title,
      body: BlocProvider(
        create: (context) => TeamsBloc(context: context)..add(TeamsEvent.init),
        child: TeamsWidget(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4.0),
            child: FloatingActionButton(
              onPressed: () {
                final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
                navigatorBloc.add(NavigatorActionTeam());
              },
              heroTag: "addNewTeam",
              tooltip: localizer.title,
              child: Icon(Icons.group_add),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
