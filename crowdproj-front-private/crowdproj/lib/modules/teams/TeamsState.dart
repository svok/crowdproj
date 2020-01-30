import 'package:crowdproj/modules/teams/models/ApiResponse.dart';

import 'models/Team.dart';

abstract class TeamsState {}

class TeamsStateNothing extends TeamsState {
  String toString() => "Nothing to do";
}

class TeamsStateWaiting extends TeamsState {
  String toString() => "Waiting for result";
}

class TeamsStateEditing extends TeamsState {
  TeamsStateEditing({
    this.team,
    this.teamEdited,
    this.errors,
  }) : super();

  Team team;
  Team teamEdited;
  List<ApiError> errors;

  String toString() =>
      team?.id == null ? "Creating a team" : "Editing team ${team?.id}";
}

class TeamsStateViewing extends TeamsState {
  TeamsStateViewing({
    this.team,
    this.errors,
  }) : super();
  Team team;
  List<ApiError> errors;

  String toString() => "Viewing team ${team?.id}";
}
