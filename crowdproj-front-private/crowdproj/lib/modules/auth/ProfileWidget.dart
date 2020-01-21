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

typedef void OnUserUpdatedCallback();

class ProfileWidget extends StatefulWidget {
  ProfileWidget({
    Key key,
    this.onUserUpdatedCallback,
    })
      : super(key: key);

  final OnUserUpdatedCallback onUserUpdatedCallback;

  @override
  _ProfileWidgetState createState() => new _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final userService = AppSession.get.authService;
  User _user = User();

  void _submit(BuildContext context) async {
    _formKey.currentState.save();

    String message;
    bool updateSuccess = false;
    try {
      await userService.updateUser(_user);
      updateSuccess = true;
      message = 'User update successful!';
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
          if (updateSuccess) {
          }
        },
      ),
      duration: new Duration(seconds: 30),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: AppSession.get.authService.getCurrentUser(),
    builder: widgetBuilder,
  );

  Widget widgetBuilder(BuildContext context, AsyncSnapshot<User> snapshot) {
    final localizer = AuthLocalizations.of(context);
    _user = snapshot?.data;
    if (_user == null) {
      return Container();
    }
    return CentralContainerWidget(
      child: Form(
        key: _formKey,
        child: new ListView(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.account_box),
              title: new TextFormField(
                initialValue: _user?.name ?? "",
                decoration: new InputDecoration(labelText: 'Name'),
                onSaved: (String name) {
                  _user.name = name;
                },
              ),
            ),
            FormFieldEmailWidget(
              email: _user?.email ?? "",
              onSaved: (String email) {
                _user.email = email;
              },
            ),
            FormSubmitButtonWidget(
              label: localizer.titleUpdate,
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
