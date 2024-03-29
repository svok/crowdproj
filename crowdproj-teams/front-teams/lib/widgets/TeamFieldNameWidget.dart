import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void SetValidationError(String error);

class TeamFieldNameWidget extends StatelessWidget {
  TeamFieldNameWidget({
    this.key,
    @required this.name,
    this.onSaved,
    this.onChanged,
    this.error,
  }) : super(key: key);

  Key key;
  String name;
  String error;
  FormFieldSetter<String> onSaved;
  ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return ListTile(
      leading: const Icon(Icons.title),
      title: TextFormField(
        key: key,
        initialValue: name,
        decoration: new InputDecoration(
          hintText: localizer.hintName,
          labelText: "${localizer.labelName} \*",
        ),
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 1,
        maxLength: nameMaxLength,
        maxLengthEnforced: true,
        onSaved: onSaved,
        onChanged: (value) {
          error = null;
          onChanged(value);
        },
        validator: (String value) {
          if (value.trim().length < validationNameMinLengh) {
            return localizer.errorTextFieldLength(
              localizer.labelName,
              validationNameMinLengh,
              value.trim().length,
            );
          }
          if (error != null) return error;
          return null;
        },
      ),
    );
  }

  static final emailValidationRegex = RegExp(r"^[\p{L}]{5,}$");

  static const validationNameMinLengh = 5;
  static const nameMaxLength = 64;
}
