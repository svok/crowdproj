import 'package:crowdproj/modules/auth/widgets/FormSubmitButtonWidget.dart';
import 'package:crowdproj/modules/teams/models/Team.dart';
import 'package:crowdproj/modules/teams/widgets/TeamFieldNameWidget.dart';
import 'package:crowdproj/modules/teams/widgets/TeamFieldSummaryWidget.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:crowdproj/widgets/CentralContainerWidget.dart';
import 'package:flutter/material.dart';

class TeamUpdateWidget extends StatefulWidget {
  TeamUpdateWidget({
    @required this.team,
  }) : super();

  @override
  _TeamUpdateWidgetState createState() => _TeamUpdateWidgetState();

  final Team team;
}

class _TeamUpdateWidgetState extends State<TeamUpdateWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String nameError;
  String summaryError;
  String descriptionError;

  _submit(BuildContext context) async {
    final form = _formKey.currentState;
    nameError = summaryError = descriptionError = null;
    if (! form.validate()) {
      return;
    }
    form.save();
    // Here we are trying to save data on server
    // If saving fails we set errors
    if (! false) {
      setState(() {
        nameError = "zzzz";
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _formKey.currentState.validate());
      });
    }
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
    return CentralContainerWidget(
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: new ListView(
          children: <Widget>[
            TeamFieldNameWidget(
              name: widget.team.name,
              error: nameError,
              onSaved: (String newValue) {
                widget.team.name = newValue;
              },
            ),
            TeamFieldSummaryWidget(
              summary: widget.team.summary,
              error: summaryError,
              onSaved: (String newValue) {
                widget.team.summary = newValue;
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
  }
}
