import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:crowdproj_common/modules/layouts/PageSimpleWithTabs.dart';
import 'package:crowdproj_common/widgets/ActivitySpinner.dart';
import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:crowdproj_teams/view/TeamViewPage.dart';
import 'package:crowdproj_teams/view/TeamViewWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamPageArguments.dart';
import '../TeamsConstants.dart';
import 'TeamUpdateBloc.dart';
import 'TeamUpdateEventChange.dart';
import 'TeamUpdateEventRead.dart';
import 'TeamUpdateEventReset.dart';
import 'TeamUpdateEventSave.dart';
import 'TeamUpdateState.dart';
import 'TeamUpdateWidget.dart';

class TeamUpdatePage extends StatelessWidget {
  static final RouteDescription<TeamPageArguments> route =
      RouteDescription<TeamPageArguments>(
          id: "TeamPageUpdate",
          pathName: "${TeamViewPage.route.pathName}/update",
          pathFormatter: ({TeamPageArguments arguments}) {
            final teamId = arguments?.teamId;
            if (teamId == null) {
              return "$BASE_TEAMS_PATH/create";
            }
            final prefix =
                TeamViewPage.route.pathFormatted(arguments: arguments);
            return "$prefix/update";
          },
          titleFormatter: ({
            BuildContext context,
            TeamPageArguments arguments,
          }) =>
              TeamsLocalizations.of(context).titleUpdate,
          builder: (BuildContext context) {
            return TeamUpdatePage();
          });

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    final arguments = ModalRoute.of(context)?.settings?.arguments;
    if (arguments == null)
      throw ArgumentError("Non-null TeamPageArguments must be provided");
    if (arguments is! TeamPageArguments)
      throw ArgumentError("Argument must have TeamPageArgument type");
    final arg = arguments as TeamPageArguments;
    return BlocProvider<TeamUpdateBloc>(
      create: (context) => TeamUpdateBloc(context: context)
        ..add(TeamUpdateEventRead(
          teamId: arg.teamId,
          team: arg.team,
        )),
      child: Builder(
        builder: (context) => PageSimpleWithTabs(
          title: TeamUpdatePage.route.titleFormatted(context: context),
          tabButtons: <Widget>[
            Tab(text: "Edit"),
            Tab(text: "Preview"),
          ],
          bodies: [
            _editorBuilder(),
            _previewerBuilder(),
          ],
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  BlocProvider.of<TeamUpdateBloc>(context)
                      .add(TeamUpdateEventSave());
                }),
            IconButton(
                icon: Icon(Icons.update),
                onPressed: () {
                  BlocProvider.of<TeamUpdateBloc>(context)
                      .add(TeamUpdateEventReset());
                }),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).maybePop();
                }),
          ],
        ),
      ),
    );
  }

  Widget _editorBuilder() =>
      BlocBuilder<TeamUpdateBloc, TeamUpdateState>(builder: (context, state) {
        final teamBloc = BlocProvider.of<TeamUpdateBloc>(context);
        return ActivitySpinner(
          isWaiting: state.isWaiting,
          child: state.team == null
              ? Container()
              : TeamUpdateWidget(
                  team: state.team,
                  errors: state.errors,
                  onTeamChanged: (newTeam) {
                    teamBloc.add(TeamUpdateEventChange(newTeam));
                  },
                ),
        );
      });

  Widget _previewerBuilder() =>
      BlocBuilder<TeamUpdateBloc, TeamUpdateState>(builder: (context, state) {
        return ActivitySpinner(
          isWaiting: state.isWaiting,
          child: TeamViewWidget(
            team: state.team,
          ),
        );
      });
}
