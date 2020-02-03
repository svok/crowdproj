import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';

import 'TeamState.dart';

class TeamStateEditing extends TeamState {
  TeamStateEditing({
    Team team,
    this.teamEdited,
    this.errors,
    bool isWaiting,
  }) : super(team: team, isWaiting: isWaiting);

  final Team teamEdited;
  final List<ApiError> errors;

  String toString() =>
      team?.id == null ? "Creating a team" : "Editing team ${team?.id}";

  @override
  List<Object> get props => [team, teamEdited, errors, isWaiting];
}

