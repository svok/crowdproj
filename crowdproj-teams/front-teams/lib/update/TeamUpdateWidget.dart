import 'package:crowdproj_teams/widgets/TeamFieldJoinabilityWidget.dart';
import 'package:crowdproj_teams/widgets/TeamFieldStatusWidget.dart';
import 'package:crowdproj_teams/widgets/TeamFieldVisibilityWidget.dart';
import 'package:crowdproj_teams_models/models/ApiResponse.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/TeamFieldDescriptionWidget.dart';
import '../widgets/TeamFieldNameWidget.dart';
import '../widgets/TeamFieldSummaryWidget.dart';
import 'TeamUpdateBloc.dart';
import 'TeamUpdateEventSave.dart';

class TeamUpdateWidget extends StatefulWidget {
  TeamUpdateWidget({
    Key key,
    this.team,
    this.errors,
    this.onTeamChanged,
    this.onTeamUpdated,
  }) : super(key: key);

  final Team team;
  final List<ApiError> errors;
  final ValueChanged<Team> onTeamChanged;
  final ValueChanged<Team> onTeamUpdated;

  @override
  _TeamUpdateWidgetState createState() => _TeamUpdateWidgetState();
}

class _TeamUpdateWidgetState extends State<TeamUpdateWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Team team;
  List<ApiError> errors;

  String nameError;
  String summaryError;
  String descriptionError;

  @override
  initState() {
    super.initState();
    team = widget.team;
    nameError = ApiError.errorString(widget.errors, "name");
    summaryError = ApiError.errorString(widget.errors, "summary");
    descriptionError = ApiError.errorString(widget.errors, "description");
  }

  _submit(BuildContext context) async {
    final form = _formKey.currentState;
    nameError = summaryError = descriptionError = null;
    if (!form.validate()) {
      return;
    }
    form.save();
    if (widget.onTeamUpdated != null) widget.onTeamUpdated(team);
    // Here we are trying to save data on server
    final teamBloc = BlocProvider.of<TeamUpdateBloc>(context);
    teamBloc.add(TeamUpdateEventSave());
    // If saving fails we set errors
//    final response = AppSession.get.teamsService.saveTeam(team);
//    if (!false) {
//      setState(() {
//        WidgetsBinding.instance
//            .addPostFrameCallback((_) => _formKey.currentState.validate());
//      });
//    }

    //    _formKey.currentState.save();
//    bool accountConfirmed;
//    String message;
//    try {
//      accountConfirmed =
//      await _userService.confirmAccount(_user.email, confirmationCode);
//      message = 'Account successfully confirmed!';
//    } on CognitoClientException catch (e) {
//      if (e.code == 'InvalidParameterException' ||
//          e.code == 'CodeMismatchException' ||
//          e.code == 'NotAuthorizedException' ||
//          e.code == 'UserNotFoundException' ||
//          e.code == 'ResourceNotFoundException') {
//        message = e.message;
//      } else {
//        message = 'Unknown client error occurred';
//      }
//    } catch (e) {
//      message = 'Unknown error occurred';
//    }
//
//    final snackBar = new SnackBar(
//      content: new Text(message),
//      action: new SnackBarAction(
//        label: 'OK',
//        onPressed: () {
//          if (accountConfirmed) {
//            widget.onAccountConfirmed();
//          }
//        },
//      ),
//      duration: new Duration(seconds: 30),
//    );
//
//    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
      team = widget.team ?? Team();
      errors = widget.errors;
      return Scrollbar(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              TeamFieldNameWidget(
                name: team.name,
                error: ApiError.errorString(errors, "name"),
                onSaved: (String newValue) {
                  team.name = newValue;
                },
                onChanged: (value) {
                  team.name = value;
                  widget.onTeamChanged(team);
                },
              ),
              TeamFieldSummaryWidget(
                summary: team.summary,
                error: ApiError.errorString(errors, "summary"),
                onSaved: (String newValue) {
                  team.summary = newValue;
                },
                onChanged: (value) {
                  team.summary = value;
                  widget.onTeamChanged(team);
                },
              ),
              TeamFieldStatusWidget(
                status: team.status,
                onChanged: (value) {
                  setState(() {
                    team.status = value;
                    widget.onTeamChanged(team);
                  });
                },
              ),
              TeamFieldVisibilityWidget(
                visibility: team.visibility,
                onChanged: (value) {
                  setState(() {
                    team.visibility = value;
                    widget.onTeamChanged(team);
                  });
                },
              ),
              TeamFieldJoinabilityWidget(
                joinability: team.joinability,
                onChanged: (value) {
                  setState(() {
                    team.joinability = value;
                    widget.onTeamChanged(team);
                  });
                },
              ),
              TeamFieldDescriptionWidget(
                description: team.description,
                error: ApiError.errorString(errors, "description"),
                onSaved: (String newValue) {
                  team.description = newValue;
                },
                onChanged: (value) {
                  team.description = value;
                  widget.onTeamChanged(team);
                },
              ),
            ],
          ),
        ),
      );
  }
}
