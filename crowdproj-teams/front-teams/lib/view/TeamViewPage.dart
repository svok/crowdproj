import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:crowdproj_common/modules/layouts/PageSimple.dart';
import 'package:crowdproj_common/widgets/ActivitySpinner.dart';
import 'package:crowdproj_teams/crowdproj_teams.dart';
import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:crowdproj_teams/update/TeamUpdatePage.dart';
import 'package:crowdproj_teams_models/ITeamsService.dart';
import 'package:crowdproj_teams_models/models/ApiResponse.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:crowdproj_teams_models/models/TeamAccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../TeamPageArguments.dart';
import '../TeamsConstants.dart';
import 'TeamViewBloc.dart';
import 'TeamViewEvent.dart';
import 'TeamViewState.dart';
import 'TeamViewWidget.dart';

class TeamViewPage extends StatelessWidget {
  static final route = RouteDescription<TeamPageArguments>(
      id: "TeamPageView",
      pathName: "${BASE_TEAMS_PATH}/{teamId}",
      pathFormatter: ({TeamPageArguments arguments}) {
        final teamId = arguments?.teamId;
        if (teamId == null)
          throw ArgumentError(
              "Non-null TeamPageArguments must be provided with non-empty teamId value");
        return "$BASE_TEAMS_PATH/${teamId}";
      },
      titleFormatter: ({
        BuildContext context,
        TeamPageArguments arguments,
      }) =>
          TeamsLocalizations.of(context).titleView,
      builder: (BuildContext context) {
        return TeamViewPage();
      });

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings?.arguments;
    if (arguments == null)
      throw ArgumentError("Non-null TeamPageArguments must be provided");
    if (arguments is! TeamPageArguments)
      throw ArgumentError("Argument must have TeamPageArgument type");
    final arg = arguments as TeamPageArguments;
    return ChangeNotifierProvider.value(
      value: TeamsModule().transportService,
      child: BlocProvider<TeamViewBloc>(
        create: (context) => TeamViewBloc(context: context)
          ..add(TeamViewEventRead(teamId: arg.teamId, team: arg.team)),
        child: PageSimple(
          title: TeamViewPage.route.titleFormatted(
            context: context,
            arguments: arg,
          ),
          actions: <Widget>[
            _updateIconButton(context),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).maybePop();
                }),
          ],
          body: Consumer<ITeamsService>(
            builder: (context, _, child) {
              BlocProvider.of<TeamViewBloc>(context).add(TeamViewEventUpdate());
              return child;
            },
            child: BlocBuilder<TeamViewBloc, TeamViewState>(
                builder: (context, state) {
              final team = state is TeamViewState ? state.team : Team();
              final List<ApiError> errors =
                  state is TeamViewState ? state.errors : [];
              return ActivitySpinner(
                isWaiting: state?.isWaiting,
                child: TeamViewWidget(team: team, errors: errors),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _updateIconButton(BuildContext context) => BlocBuilder<TeamViewBloc, TeamViewState>(builder: (context, state) {
    final arg = TeamPageArguments(teamId: state.teamId, team: state.team);
    return state?.team?.can(TeamAccess.UPDATE) == true
        ? IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: TeamUpdatePage.route.builder,
            settings: RouteSettings(
              name: TeamUpdatePage.route
                  .pathFormatted(arguments: arg),
              arguments: arg,
            ),
          ));
        })
        : Container();
  });

}
