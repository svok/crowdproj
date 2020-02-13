import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';

class TeamFieldSummaryWidget extends StatelessWidget {
  TeamFieldSummaryWidget({
    Key key,
    @required this.summary,
    this.error,
    this.onSaved,
    this.requiredField, this.onChanged,
  }) : super(key: key);

  final String summary;
  String error;
  final bool requiredField;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return ListTile(
      leading: const Icon(Icons.group),
      title: new TextFormField(
        key: key,
        initialValue: summary,
        decoration: new InputDecoration(
          hintText: localizer.hintSummary,
          labelText: "${localizer.labelSummary} \*",
        ),
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 5,
        maxLength: summaryMaxLength,
        maxLengthEnforced: true,
        onSaved: onSaved,
        onChanged: (value) {
          error = null;
          onChanged(value);
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
