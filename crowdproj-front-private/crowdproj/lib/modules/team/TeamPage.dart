import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/modules/team/TeamBloc.dart';
import 'package:crowdproj/modules/team/widgets/TeamUpdateWidget.dart';
import 'package:crowdproj/modules/team/widgets/TeamViewWidget.dart';
import 'package:crowdproj/modules/teams/TeamsPage.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TeamPageArguments.dart';
import 'events/TeamEventTeamInit.dart';
import '../../api/models/Team.dart';
import 'states/TeamState.dart';
import 'states/TeamStateEditing.dart';
import 'states/TeamStateViewing.dart';

class TeamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamPageState();

  final team = Team();

  static String titleFormatter(
          {BuildContext context, RouteSettings settings}) =>
      TeamsLocalizations.of(context).title;

  static String pathFormatter({RouteSettings settings}) {
    final teamId = (settings?.arguments as TeamPageArguments)?.teamId;
    final prefix = TeamPage.route.pathName;
    return teamId == null ? "$prefix/create" : "$prefix/${teamId}";
  }

  static final route = RouteDescription(
      id: "TeamPage",
      pathName: "${TeamsPage.route.pathName}/team",
      pathFormatter: TeamPage.pathFormatter,
      titleFormatter: TeamPage.titleFormatter,
      builder: (BuildContext context) {
        return TeamPage();
      });
}

class _TeamPageState extends State<TeamPage> {

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    final arguments = ModalRoute.of(context).settings.arguments;
    final args = arguments is TeamPageArguments ? arguments : null;
    return PageSimple(
      title: localizer.title,
      body: Container(
        child: BlocProvider(
          create: (context) => TeamBloc(context: context)
          ..add(TeamEventTeamInit(team: args?.team, teamId: args?.teamId)),
          child: BlocBuilder<TeamBloc, TeamState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case TeamStateEditing:
                return TeamUpdateWidget();
              case TeamStateViewing:
                return TeamViewWidget();
              default:
                return Container();
            }
          },
        ),
        ),
      ),
    );
    PageSimple(title: localizer.title, body: TeamUpdateWidget());
  }
}
