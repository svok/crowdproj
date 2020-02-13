import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/modules/layouts/PageSimpleWithTabs.dart';
import 'package:crowdproj/modules/team/TeamBloc.dart';
import 'package:crowdproj/modules/team/events/TeamEventPreviewRequested.dart';
import 'package:crowdproj/modules/team/states/TeamStateEditing.dart';
import 'package:crowdproj/modules/team/widgets/TeamUpdateWidget.dart';
import 'package:crowdproj/modules/team/widgets/TeamViewWidget.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:crowdproj/widgets/ActivitySpinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/models/Team.dart';
import 'states/TeamState.dart';
import 'states/TeamStateViewing.dart';

class TeamPageUpdate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamPageUpdateState();
}

class _TeamPageUpdateState extends State<TeamPageUpdate> {
  Team team;

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
//    final teamBloc = BlocProvider.of<TeamBloc>(context);
    return PageSimpleWithTabs(
      title: localizer.title,
      tabButtons: <Widget>[
        Tab(text: "Edit"),
        Tab(text: "Preview"),
      ],
//      onTabSelected: (index) {
//        if (index == 1)
//          teamBloc.add(TeamEventPreviewRequested(team: team));
//      },
      bodies: [
        _editorBuilder(),
        _previewerBuilder(),
      ],
    );
  }

  Widget _editorBuilder() {
    return BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
      team = state is TeamStateEditing ? state.team : Team();
      final List<ApiError> errors =
          state is TeamStateEditing ? state.errors : [];
      print("TEAM ED: ${team} ${team?.id}");
      final teamBloc = BlocProvider.of<TeamBloc>(context);
      return ActivitySpinner(
        isWaiting: state.isWaiting,
        child: TeamUpdateWidget(
          team: team,
          errors: errors,
          onTeamChanged: (newTeam) {
//            print("TEAM CHANGED to $newTeam");
//            teamBloc.add(TeamEventPreviewRequested(team: newTeam));
            team = newTeam;
          },
        ),
      );
    });
  }

  Widget _previewerBuilder() {
    return BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
      print("TEAM VW: ${state?.team} ${state?.team?.id}");
      return ActivitySpinner(
        isWaiting: state.isWaiting,
        child: TeamViewWidget(
          team: state.team,
        ),
      );
    });
  }
}
