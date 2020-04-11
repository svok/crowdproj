import 'package:crowdproj_common/widgets/RadioGroupWidget.dart';
import 'package:crowdproj_common/widgets/RadioItemWidget.dart';
import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:crowdproj_teams_models/models/TeamStatus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef void SetValidationError(String error);

class TeamFieldStatusWidget extends StatelessWidget {
  TeamFieldStatusWidget({
    Key key,
    @required this.status,
    this.onSaved,
    this.onChanged,
    this.error,
  }) : super(key: key);

  final TeamStatus status;
  final String error;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<TeamStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return ListTile(
      leading: Icon(FontAwesomeIcons.toggleOff),
      title: Text(localizer.labelStatus),
      subtitle: RadioGroupWidget<TeamStatus>(
        children: [
          RadioItemWidget<TeamStatus>(
            title: Text(localizer.labelStatusActive),
            value: TeamStatus.active,
            groupValue: status,
            onChanged: onChanged,
          ),
          RadioItemWidget<TeamStatus>(
            value: TeamStatus.pending,
            groupValue: status,
            onChanged: onChanged,
            title: Text(localizer.labelStatusPending),
          ),
          RadioItemWidget<TeamStatus>(
            value: TeamStatus.closed,
            groupValue: status,
            onChanged: onChanged,
            title: Text(localizer.labelStatusClosed),
          ),
        ],
      ),
    );
  }
}
