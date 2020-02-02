import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamsEventViewRequested.dart';
import 'package:crowdproj/modules/teams/widgets/TeamUpdateWidget.dart';
import 'package:crowdproj/modules/teams/widgets/TeamViewWidget.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:crowdproj/widgets/CentralContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TeamsPage.dart';
import 'models/Team.dart';

class TeamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamPageState();

  final team = Team();

  static String titleFormatter(
          {BuildContext context, RouteSettings settings}) =>
      TeamsLocalizations.of(context).title;

  static String pathFormatter({RouteSettings settings}) {
    final teamId = (settings?.arguments as TeamsPageEditArguments)?.teamId;
    final prefix = TeamsPage.route.pathName;
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
    final args =
        ModalRoute.of(context).settings?.arguments as TeamsPageEditArguments;
    final teamId = args?.teamId;
    BlocProvider.of<TeamsBloc>(context)
        .add(TeamsEventViewRequested(teamId: teamId));
    final localizer = TeamsLocalizations.of(context);
    return PageSimple(
      title: localizer.title,
      body: CentralContainerWidget(
        child: BlocBuilder<TeamsBloc, TeamsState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case TeamsStateEditing:
                return TeamUpdateWidget();
              case TeamsStateViewing:
                return TeamViewWidget();
              default:
                return Container();
            }
          },
        ),
      ),
    );
    PageSimple(title: localizer.title, body: TeamUpdateWidget());
  }
}

class TeamsPageEditArguments {
  TeamsPageEditArguments({
    this.teamId,
  }) : super();

  String teamId;
}
