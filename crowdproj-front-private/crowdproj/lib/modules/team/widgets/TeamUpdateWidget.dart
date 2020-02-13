import 'package:crowdproj/modules/auth/widgets/FormSubmitButtonWidget.dart';
import 'package:crowdproj/modules/team/events/TeamEventSaveRequested.dart';
import 'package:crowdproj/modules/team/states/TeamState.dart';
import 'package:crowdproj/modules/team/states/TeamStateEditing.dart';
import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:crowdproj/widgets/ActivitySpinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamBloc.dart';
import 'TeamFieldNameWidget.dart';
import 'TeamFieldSummaryWidget.dart';

typedef OnTeamUpdate(Team team);

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
  final OnTeamUpdate onTeamChanged;
  final OnTeamUpdate onTeamUpdated;

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
    final teamBloc = BlocProvider.of<TeamBloc>(context);
    teamBloc.add(TeamEventSaveRequested(team: team));
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
    final localizer = TeamsLocalizations.of(context);
    return BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
      if (!(state is TeamStateEditing)) return Container();
      team = (state as TeamStateEditing)?.team ?? Team();
      errors = state is TeamStateEditing ? state.errors : [];
      return ActivitySpinner(
        isWaiting: state?.isWaiting,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Scrollbar(
                child: _formBuilder(),
              ),
            ),
            FormSubmitButtonWidget(
              label: localizer.labelSave,
              onPressed: () {
                _submit(context);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _formBuilder() {
    return Container(
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
//          MdEditorWidget(
//            initialText: team.description,
//            onSaved: (String text) {
//              team.description = text;
//            },
//          ),
            TextFormField(
              initialValue: team.description,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 7,
              onSaved: (String text) {
                team.description = text;
              },
              onChanged: (String text) {
                team.description = text;
                widget.onTeamChanged(team);
              },
            ),
          ],
        ),
      ),
    );
  }
}
