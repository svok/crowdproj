import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamFieldSummaryWidget extends StatelessWidget {
  TeamFieldSummaryWidget({
    this.key,
    @required this.summary,
    this.error,
    this.onSaved,
  }): super(key: key);

  Key key;
  String summary;
  String error;
  FormFieldSetter<String> onSaved;

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return ListTile(
      leading: const Icon(Icons.email),
      title: new TextFormField(
        key: key,
        initialValue: summary,
        decoration: new InputDecoration(
            hintText: localizer.hintSummary, labelText: localizer.labelSummary),
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 5,
        maxLength: summaryMaxLength,
        maxLengthEnforced: true,
        onSaved: onSaved,
        onChanged: (_) {
          error = null;
        },
        validator: (String value) {
          if (value.trim().length < validationSummaryMinLengh) {
            return localizer.errorTextFieldLength(
              localizer.labelSummary,
              validationSummaryMinLengh,
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

  static const validationSummaryMinLengh = 5;
  static const summaryMaxLength = 300;
}
