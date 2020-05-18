import 'package:crowdproj_common/widgets/CentralContainerWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:crowdproj/modules/auth/widgets/FormFieldEmailWidget.dart';
import 'package:crowdproj/modules/auth/widgets/FormFieldPasswordWidget.dart';
import 'package:crowdproj/modules/auth/widgets/FormSubmitButtonWidget.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';

import '../../AppSession.dart';
import 'User.dart';

typedef void OnSignedInCallback();
typedef void OnUnconfirmedCallback();

class SigninWidget extends StatefulWidget {
  SigninWidget(
      {Key key,
      this.email,
      this.onSignediInCallback,
      this.onUnconfirmedCallback})
      : super(key: key);

  final String email;
  final OnSignedInCallback onSignediInCallback;
  final OnUnconfirmedCallback onUnconfirmedCallback;

  @override
  _SigninWidgetState createState() => new _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _userService = AppSession.get.authService;
  User _user = new User();

  submit(BuildContext context) async {
    final form = _formKey.currentState;
    if (! form.validate()) return;
    form.save();
    String message;
    try {
      _user = await _userService.signIn(_user.email.trim(), _user.password.trim());
      message = 'User sucessfully logged in!';
      if (!_user.confirmed) {
        message = 'Please confirm user account';
        widget.onUnconfirmedCallback();
      } else {
        widget.onSignediInCallback();
      }
    } on CognitoClientException catch (e, stacktrace) {
      if (e.code == 'InvalidParameterException' ||
          e.code == 'NotAuthorizedException' ||
          e.code == 'UserNotFoundException' ||
          e.code == 'ResourceNotFoundException') {
        message = e.message;
        print("Auth failed: $e");
        print(stacktrace);
      } else {
        if (kDebugMode) {
          print(e);
          print(stacktrace);
        }
        message = 'An unknown client error occured';
      }
    } catch (e) {
      message = 'An unknown error occurred';
      throw e;
    }
    final snackBar = new SnackBar(
      content: new Text(message),
      action: new SnackBarAction(
        label: 'OK',
        onPressed: () async {
          if (_user.hasAccess) {
            widget.onSignediInCallback();
          }
        },
      ),
      duration: new Duration(seconds: 30),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    if (AppSession.get.authService.isAuthenticated()) {
      widget.onSignediInCallback();
      return Container();
    }
    final localizer = AuthLocalizations.of(context);

    return Builder(
      builder: (BuildContext context) {
        return CentralContainerWidget(
          child: Form(
//            autovalidate: true,
            key: _formKey,
            child: new ListView(
              children: <Widget>[
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
                  label: localizer.titleLogin,
                  onPressed: () {
                    submit(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
