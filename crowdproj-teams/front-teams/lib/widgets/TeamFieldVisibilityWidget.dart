import 'package:crowdproj_common/widgets/RadioGroupWidget.dart';
import 'package:crowdproj_common/widgets/RadioItemWidget.dart';
import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:crowdproj_teams_models/models/TeamVisibility.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef void SetValidationError(String error);

class TeamFieldVisibilityWidget extends StatelessWidget {
  TeamFieldVisibilityWidget({
    Key key,
    @required this.visibility,
    this.onSaved,
    this.onChanged,
    this.error,
  }) : super(key: key);

  final TeamVisibility visibility;
  final String error;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<TeamVisibility> onChanged;

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return ListTile(
      leading: Icon(Icons.visibility),
      title: Text(localizer.labelStatus),
      subtitle: RadioGroupWidget<TeamVisibility>(
        children: [
          RadioItemWidget<TeamVisibility>(
            title: Text(localizer.labelVisibilityPublic),
            value: TeamVisibility.public,
            groupValue: visibility,
            onChanged: onChanged,
          ),
          RadioItemWidget<TeamVisibility>(
            value: TeamVisibility.registeredOnly,
            groupValue: visibility,
            onChanged: onChanged,
            title: Text(localizer.labelVisibilityRegistered),
          ),
          RadioItemWidget<TeamVisibility>(
            value: TeamVisibility.groupOnly,
            groupValue: visibility,
            onChanged: onChanged,
            title: Text(localizer.labelVisibilityGroup),
          ),
          RadioItemWidget<TeamVisibility>(
            value: TeamVisibility.membersOnly,
            groupValue: visibility,
            onChanged: onChanged,
            title: Text(localizer.labelVisibilityMembers),
          ),
        ],
      ),
    );
  }
}
