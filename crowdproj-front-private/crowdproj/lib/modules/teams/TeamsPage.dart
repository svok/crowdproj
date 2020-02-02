import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionTeam.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/Team.dart';

class TeamsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsPageState();

  final team = Team();

  static String titleFormatter(
          {BuildContext context, RouteSettings settings}) =>
      TeamsLocalizations.of(context).title;

  static String pathFormatter({RouteSettings settings}) => "/teams";

  static final route = RouteDescription(
      id: "TeamsPage",
      pathName: "/teams",
      pathFormatter: TeamsPage.pathFormatter,
      titleFormatter: TeamsPage.titleFormatter,
      builder: (BuildContext context) {
        return TeamsPage();
      });
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    final TeamsBloc teamsBloc = BlocProvider.of<TeamsBloc>(context);
    return PageSimple(
      title: localizer.title,
      body: BlocBuilder<TeamsBloc, TeamsState>(
        builder: (context, state) {
          return Container();
        },
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
              heroTag: "teamEdit",
              tooltip: localizer.title,
              child: Icon(Icons.group_add),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
