import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/widgets/TeamUpdateWidget.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TeamsPage.dart';
import 'models/Team.dart';

class TeamsPageEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsPageEditState();

  final team = Team();

  static String titleFormatter(
      {BuildContext context, RouteSettings settings}) =>
      TeamsLocalizations
          .of(context)
          .title;

  static String pathFormatter({RouteSettings settings}) {
    final teamId = (settings?.arguments as TeamsPageEditArguments)?.teamId;
    final prefix = TeamsPage.route.pathName;
    return teamId == null ? "$prefix/create" : "$prefix/${teamId}/update";
  }

  static final route = RouteDescription(
      id: "TeamsPage",
      pathName: "${TeamsPage.route.pathName}/update",
      pathFormatter: TeamsPageEdit.pathFormatter,
      titleFormatter: TeamsPageEdit.titleFormatter,
      builder: (BuildContext context) {
        return TeamsPageEdit();
      });
}

class _TeamsPageEditState extends State<TeamsPageEdit> {
  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return PageSimple(
        title: localizer.title,
        body: TeamUpdateWidget()
    );
  }
}

class TeamsPageEditArguments {
  TeamsPageEditArguments({
    this.teamId,
  }) : super();

  String teamId;
}
