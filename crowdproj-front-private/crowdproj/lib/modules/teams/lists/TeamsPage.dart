import 'package:crowdproj/api/models/TeamRelations.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/modules/layouts/PageSimpleWithTabs.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionTeam.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:crowdproj/modules/teams/TeamsConstants.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/models/Team.dart';
import 'TeamsBloc.dart';
import 'TeamsEventInit.dart';
import 'TeamsPageArgs.dart';
import 'TeamsWidget.dart';

class TeamsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsPageState();

  final team = Team();

  static final RouteDescription<TeamsPageArgs> route = RouteDescription(
      id: "TeamsPage",
      pathName: BASE_TEAMS_PATH,
      pathFormatter: ({TeamsPageArgs arguments}) => BASE_TEAMS_PATH,
      titleFormatter: ({BuildContext context, TeamsPageArgs arguments}) =>
          TeamsLocalizations.of(context).titleTeams,
      builder: (BuildContext context) {
        return TeamsPage();
      });
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return PageSimple(
      title: localizer.titleTeams,
      body: BlocProvider(
          create: (context) =>
              TeamsBloc(context, TeamRelations.accessed)..add(TeamsEventInit()),
          child: TeamsWidget(),
        ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4.0),
            child: FloatingActionButton(
              onPressed: () {
              },
              heroTag: "searchTeams",
              tooltip: localizer.labelSearchTeams,
              child: Icon(Icons.search),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
