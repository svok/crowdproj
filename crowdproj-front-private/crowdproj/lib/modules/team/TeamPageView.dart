import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/modules/team/TeamBloc.dart';
import 'package:crowdproj/modules/team/widgets/TeamViewWidget.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:crowdproj/widgets/ActivitySpinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/models/Team.dart';
import 'states/TeamState.dart';
import 'states/TeamStateViewing.dart';

class TeamPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamPageViewState();
}

class _TeamPageViewState extends State<TeamPageView> {
  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return PageSimple(
      title: localizer.title,
      body: BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
        final team = state is TeamStateViewing ? state.team : Team();
        final List<ApiError> errors =
            state is TeamStateViewing ? state.errors : [];
        return ActivitySpinner(
          isWaiting: state?.isWaiting,
          child: TeamViewWidget(team: team, errors: errors),
        );
      }),
    );
  }
}
