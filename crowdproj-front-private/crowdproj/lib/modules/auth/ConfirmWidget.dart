import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/auth/widgets/FormLinkWidget.dart';
import 'package:crowdproj/modules/auth/widgets/FormSubmitButtonWidget.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';
import 'package:crowdproj/widgets/CentralContainerWidget.dart';

import 'User.dart';
import 'widgets/FormFieldEmailWidget.dart';

typedef void OnAccountConfirmed();

class ConfirmWidget extends StatefulWidget {
  ConfirmWidget({Key key, this.email, this.onAccountConfirmed})
      : super(key: key);

  final String email;
  final OnAccountConfirmed onAccountConfirmed;

  @override
  _ConfirmWidgetState createState() => new _ConfirmWidgetState();
}

class _ConfirmWidgetState extends State<ConfirmWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String confirmationCode;
  User _user = new User();
  final _userService = AppSession.get.authService;

  _submit(BuildContext context) async {
    _formKey.currentState.save();
    bool accountConfirmed;
    String message;
    try {
      accountConfirmed =
          await _userService.confirmAccount(_user.email, confirmationCode);
      message = 'Account successfully confirmed!';
    } on CognitoClientException catch (e) {
      if (e.code == 'InvalidParameterException' ||
          e.code == 'CodeMismatchException' ||
          e.code == 'NotAuthorizedException' ||
          e.code == 'UserNotFoundException' ||
          e.code == 'ResourceNotFoundException') {
        message = e.message;
      } else {
        message = 'Unknown client error occurred';
      }
    } catch (e) {
      message = 'Unknown error occurred';
    }

    final snackBar = new SnackBar(
      content: new Text(message),
      action: new SnackBarAction(
        label: 'OK',
        onPressed: () {
          if (accountConfirmed) {
            widget.onAccountConfirmed();
          }
        },
      ),
      duration: new Duration(seconds: 30),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  _resendConfirmation(BuildContext context) async {
    _formKey.currentState.save();
    String message;
    try {
      await _userService.resendConfirmationCode(_user.email);
      message = 'Confirmation code sent to ${_user.email}!';
    } on CognitoClientException catch (e) {
      if (e.code == 'LimitExceededException' ||
          e.code == 'InvalidParameterException' ||
          e.code == 'ResourceNotFoundException') {
        message = e.message;
      } else {
        message = 'Unknown client error occurred';
      }
    } catch (e) {
      message = 'Unknown error occurred';
    }

    final snackBar = new SnackBar(
      content: new Text(message),
      action: new SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
      duration: new Duration(seconds: 30),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final localizer = AuthLocalizations.of(context);
    final Size screenSize = MediaQuery.of(context).size;
    return CentralContainerWidget(
      child: Form(
        key: _formKey,
        child: new ListView(
          children: <Widget>[
            FormFieldEmailWidget(
              email: widget.email,
              onSaved: (String email) {
                _user.email = email;
              },
            ),
            new ListTile(
              leading: const Icon(Icons.lock),
              title: new TextFormField(
                decoration: new InputDecoration(labelText: 'Confirmation Code'),
                onSaved: (String code) {
                  confirmationCode = code;
                },
              ),
            ),
            FormSubmitButtonWidget(
              label: localizer.titleConfirm,
              onPressed: () {
                _submit(context);
              },
            ),
            FormLinkWidget(
              label: 'Resend Confirmation Code',
              onPressed: () {
                _resendConfirmation(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
