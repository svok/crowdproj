import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/widgets/TeamUpdateWidget.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/Team.dart';

class TeamsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsPageState();

  final team = Team();

  static String titleFormatter({BuildContext context, RouteSettings settings}) =>
      TeamsLocalizations.of(context).title;

  static String pathFormatter({RouteSettings settings}) => "/teams";

  static final route = RouteDescription(
      id: "TeamsPage",
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
          switch(state.runtimeType) {
            case TeamsStateViewing: return Container();
            case TeamsStateEditing: return TeamUpdateWidget(state: state);
            case TeamsStateWaiting: return CircularProgressIndicator();
            default: return Container();
          }

        },
      ),
    );
  }
}
