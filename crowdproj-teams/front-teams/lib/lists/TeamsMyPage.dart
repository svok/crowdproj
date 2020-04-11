import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:crowdproj_common/modules/layouts/PageSimple.dart';
import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:crowdproj_teams/update/TeamUpdatePage.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:crowdproj_teams_models/models/TeamRelations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamPageArguments.dart';
import '../TeamsConstants.dart';
import 'TeamsBloc.dart';
import 'TeamsEventInit.dart';
import 'TeamsPageArgs.dart';
import 'TeamsWidget.dart';

class TeamsMyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsMyPageState();

  final team = Team();

  static final RouteDescription<TeamsPageArgs> route = RouteDescription(
      id: "TeamsMyPage",
      pathName: "$BASE_TEAMS_PATH/my",
      pathFormatter: ({TeamsPageArgs arguments}) => "$BASE_TEAMS_PATH/my",
      titleFormatter: ({BuildContext context, TeamsPageArgs arguments}) =>
          TeamsLocalizations.of(context).titleTeams,
      builder: (BuildContext context) {
        return TeamsMyPage();
      });
}

class _TeamsMyPageState extends State<TeamsMyPage> {
  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return PageSimple(
      title: localizer.titleTeams,
      body: BlocProvider(
        create: (context) =>
            TeamsBloc(context, TeamRelations.member)..add(TeamsEventInit()),
        child: TeamsWidget(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4.0),
            child: FloatingActionButton(
              onPressed: () {
                final navigator = Navigator.of(context);
                final arguments = TeamPageArguments(teamId: null);
                final route = TeamUpdatePage.route;
                navigator.push(MaterialPageRoute(
                  builder: route.builder,
                  settings: RouteSettings(
                    name: route.pathFormatted(arguments: arguments),
                    arguments: arguments,
                  ),
                ));

//                final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
//                navigatorBloc.add(NavigatorActionTeam());
              },
              heroTag: "addNewTeam",
              tooltip: localizer.titleTeams,
              child: Icon(Icons.group_add),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
