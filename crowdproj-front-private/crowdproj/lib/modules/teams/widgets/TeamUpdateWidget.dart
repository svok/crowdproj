import 'package:crowdproj/modules/auth/widgets/FormSubmitButtonWidget.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamEventSaveRequested.dart';
import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/modules/teams/widgets/TeamFieldNameWidget.dart';
import 'package:crowdproj/modules/teams/widgets/TeamFieldSummaryWidget.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamsBloc.dart';

class TeamUpdateWidget extends StatefulWidget {
  @override
  _TeamUpdateWidgetState createState() => _TeamUpdateWidgetState();
}

class _TeamUpdateWidgetState extends State<TeamUpdateWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Team team = Team();
  String nameError;
  String summaryError;
  String descriptionError;

  _submit(BuildContext context) async {
    final form = _formKey.currentState;
    nameError = summaryError = descriptionError = null;
    if (!form.validate()) {
      return;
    }
    form.save();
    // Here we are trying to save data on server
    final teamsBloc = BlocProvider.of<TeamsBloc>(context);
    teamsBloc.add(TeamEventSaveRequested(team: team));
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
    return BlocBuilder<TeamsBloc, TeamsState>(builder: (context, state) {
      if (!(state is TeamsStateEditing)) return Container();
      final tm = (state as TeamsStateEditing)?.team ?? this.team;
      final List<ApiError> errors = state is TeamsStateEditing ? state.errors : [];
      return Container(
        child: Form(
          key: _formKey,
          child: new ListView(
            children: <Widget>[
              TeamFieldNameWidget(
                name: tm.name,
                error: ApiError.errorString(errors, "name"),
                onSaved: (String newValue) {
                  team.name = newValue;
                },
              ),
              TeamFieldSummaryWidget(
                summary: tm.summary,
                error: ApiError.errorString(errors, "summary"),
                onSaved: (String newValue) {
                  team.summary = newValue;
                },
              ),
              TextFormField(
                initialValue: tm.description,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                onSaved: (String text) {
                  team.description = text;
                },
              ),
              FormSubmitButtonWidget(
                label: localizer.labelSave,
                onPressed: () {
                  _submit(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
