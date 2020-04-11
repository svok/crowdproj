import 'package:crowdproj_common/widgets/RadioGroupWidget.dart';
import 'package:crowdproj_common/widgets/RadioItemWidget.dart';
import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:crowdproj_teams_models/models/TeamJoinability.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef void SetValidationError(String error);

class TeamFieldJoinabilityWidget extends StatelessWidget {
  TeamFieldJoinabilityWidget({
    Key key,
    @required this.joinability,
    this.onSaved,
    this.onChanged,
    this.error,
  }) : super(key: key);

  final TeamJoinability joinability;
  final String error;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<TeamJoinability> onChanged;

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return ListTile(
      leading: Icon(FontAwesomeIcons.idBadge),
      title: Text(localizer.labelStatus),
      subtitle: RadioGroupWidget<TeamJoinability>(
        children: [
          RadioItemWidget<TeamJoinability>(
            title: Text(localizer.labelJoinabilityOwner),
            value: TeamJoinability.byOwner,
            groupValue: joinability,
            onChanged: onChanged,
          ),
          RadioItemWidget<TeamJoinability>(
            value: TeamJoinability.byMember,
            groupValue: joinability,
            onChanged: onChanged,
            title: Text(localizer.labelJoinabilityMember),
          ),
          RadioItemWidget<TeamJoinability>(
            value: TeamJoinability.byUser,
            groupValue: joinability,
            onChanged: onChanged,
            title: Text(localizer.labelJoinabilityUser),
          ),
        ],
      ),
    );
  }
}
