
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';

class FormFieldPasswordWidget extends StatelessWidget {

  FormFieldPasswordWidget({
    this.onSaved,
  });

  FormFieldSetter<String> onSaved;

  @override
  Widget build(BuildContext context) {
    final localizer = AuthLocalizations.of(context);
    return ListTile(
      leading: const Icon(Icons.lock),
      title: new TextFormField(
        decoration:
        new InputDecoration(labelText: 'Password'),
        obscureText: true,
        onSaved: onSaved,
      ),
    );
  }
}
