import 'package:crowdproj/api/models/ApiResponse.dart';

import '../../api/models/Team.dart';

abstract class TeamsState {
  TeamsState({this.isWaiting = false}): super();
  bool isWaiting;
}

class TeamsStateNothing extends TeamsState {
  String toString() => "Nothing to do";
}

class TeamsStateEditing extends TeamsState {
  TeamsStateEditing({
    this.team,
    this.teamEdited,
    this.errors,
    bool isWaiting,
  }) : super(isWaiting: isWaiting);

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
    bool isWaiting,
  }) : super(isWaiting: isWaiting);
  Team team;
  List<ApiError> errors;

  String toString() => "Viewing team ${team?.id}";
}
