import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void SetValidationError(String error);

class TeamFieldDescriptionWidget extends StatelessWidget {
  TeamFieldDescriptionWidget({
    Key key,
    @required this.description,
    this.onSaved,
    this.onChanged,
    this.error,
  }) : super(key: key);

  final String description;
  String error;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return ListTile(
//      leading: const Icon(Icons.email),
      title: TextFormField(
        initialValue: description,
        keyboardType: TextInputType.multiline,
        decoration: new InputDecoration(
          hintText: localizer.hintDescription,
          labelText: "${localizer.labelDescription} \*",
        ),
        minLines: 3,
        maxLines: 7,
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

  static const validationNameMinLengh = 5;
  static const nameMaxLength = 64;
}
