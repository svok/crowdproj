import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';

class FormFieldEmailWidget extends StatelessWidget {
  FormFieldEmailWidget({
    @required this.email,
    this.onSaved,
  });

  String email;
  FormFieldSetter<String> onSaved;

  @override
  Widget build(BuildContext context) {
    final localizer = AuthLocalizations.of(context);
    return ListTile(
      leading: const Icon(Icons.email),
      title: new TextFormField(
        initialValue: email,
        decoration: new InputDecoration(
          hintText: 'example@inspire.my',
          labelText: 'Email',
        ),
        keyboardType: TextInputType.emailAddress,
        onSaved: onSaved,
        validator: (String value) {
          bool emailValid = emailValidationRegex.hasMatch(value);
          if (emailValid) return null;
          return localizer.emailError(value);
        },
      ),
    );
  }

  static final emailValidationRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
