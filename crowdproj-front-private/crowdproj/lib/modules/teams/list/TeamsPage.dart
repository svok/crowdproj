import 'package:crowdproj/api/models/TeamRelations.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/layouts/PageSimpleWithTabs.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionTeam.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:crowdproj/modules/teams/TeamsConstants.dart';
import 'package:crowdproj/modules/teams/list/TeamsBloc.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/models/Team.dart';
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
          TeamsLocalizations.of(context).title,
      builder: (BuildContext context) {
        return TeamsPage();
      });
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return PageSimpleWithTabs(
      title: localizer.title,
      tabButtons: <Widget>[
        Tab(text: "My",),
        Tab(text: "Invitations",),
        Tab(text: "All",),
      ],
      bodies: [
        BlocProvider(
          create: (context) =>
              TeamsBloc(context, TeamRelations.member)..add(TeamsEventInit()),
          child: TeamsWidget(),
        ),
        BlocProvider(
          create: (context) =>
              TeamsBloc(context, TeamRelations.invitations)..add(TeamsEventInit()),
          child: TeamsWidget(),
        ),
        BlocProvider(
          create: (context) =>
              TeamsBloc(context, TeamRelations.accessed)..add(TeamsEventInit()),
          child: TeamsWidget(),
        ),
      ],
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
