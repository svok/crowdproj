import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/auth/widgets/FormSubmitButtonWidget.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamsEvent.dart';
import 'package:crowdproj/modules/teams/events/TeamsEventSaveRequested.dart';
import 'package:crowdproj/modules/teams/models/ApiResponse.dart';
import 'package:crowdproj/modules/teams/models/Team.dart';
import 'package:crowdproj/modules/teams/widgets/TeamFieldNameWidget.dart';
import 'package:crowdproj/modules/teams/widgets/TeamFieldSummaryWidget.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:crowdproj/widgets/CentralContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamsBloc.dart';

class TeamViewWidget extends StatefulWidget {
  @override
  _TeamViewWidgetState createState() => _TeamViewWidgetState();
}

class _TeamViewWidgetState extends State<TeamViewWidget> {

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return BlocBuilder<TeamsBloc, TeamsState>(builder: (context, state) {
      final team = state is TeamsStateViewing ? state.team : Team();
      final List<ApiError> errors = state is TeamsStateViewing ? state.errors : [];
      return CentralContainerWidget(
        child: Card(
          child: new ListView(
            children: <Widget>[
              TeamFieldNameWidget(
                name: team?.name,
              ),
              TeamFieldSummaryWidget(
                summary: team?.summary,
              ),
              FormSubmitButtonWidget(
                label: MaterialLocalizations.of(context).closeButtonLabel,
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
