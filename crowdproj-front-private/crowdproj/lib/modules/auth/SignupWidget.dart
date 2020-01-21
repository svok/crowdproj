import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/auth/widgets/FormFieldEmailWidget.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';
import 'package:crowdproj/widgets/CentralContainerWidget.dart';

import 'User.dart';
import 'widgets/FormFieldPasswordWidget.dart';
import 'widgets/FormSubmitButtonWidget.dart';

typedef void OnUnconfirmedCallback();

class SignupWidget extends StatefulWidget {
  SignupWidget({Key key, this.email, this.onUnconfirmedCallback})
      : super(key: key);

  final String email;
  final OnUnconfirmedCallback onUnconfirmedCallback;

  @override
  _SignupWidgetState createState() => new _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  User _user = new User();
  final userService = AppSession.get.authService;

  void submit(BuildContext context) async {
    _formKey.currentState.save();

    String message;
    bool signUpSuccess = false;
    try {
      _user = await userService.signUp(_user.email, _user.password, _user.name);
      signUpSuccess = true;
      message = 'User sign up successful!';
    } on CognitoClientException catch (e) {
      if (e.code == 'UsernameExistsException' ||
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
        onPressed: () {
          if (signUpSuccess) {
            widget.onUnconfirmedCallback();
          }
        },
      ),
      duration: new Duration(seconds: 30),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final localizer = AuthLocalizations.of(context);
    return CentralContainerWidget(
      child: Form(
        key: _formKey,
        child: new ListView(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.account_box),
              title: new TextFormField(
                decoration: new InputDecoration(labelText: 'Name'),
                onSaved: (String name) {
                  _user.name = name;
                },
              ),
            ),
            FormFieldEmailWidget(
              email: widget.email,
              onSaved: (String email) {
                _user.email = email;
              },
            ),
            FormFieldPasswordWidget(
              onSaved: (String password) {
                _user.password = password;
              },
            ),
            FormSubmitButtonWidget(
              label: localizer.titleRegister,
              onPressed: () {
                submit(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
