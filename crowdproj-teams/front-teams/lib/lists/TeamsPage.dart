import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:crowdproj_common/modules/layouts/PageSimple.dart';
import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:crowdproj_teams_models/models/TeamRelations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamsConstants.dart';
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
        create: (context) {
          print("CREATING TeamsBloc");
          return TeamsBloc(context, TeamRelations.accessed)
            ..add(TeamsEventInit());
        },
        child: TeamsWidget(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4.0),
            child: FloatingActionButton(
              onPressed: () {},
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
