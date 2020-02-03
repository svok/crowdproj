import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:equatable/equatable.dart';

import '../../api/models/Team.dart';

abstract class TeamsState extends Equatable {
  TeamsState({this.isWaiting = false}): super();
  final bool isWaiting;
}

class TeamsStateNothing extends TeamsState {
  String toString() => "Nothing to do";

  @override
  List<Object> get props => [];
}

class TeamsStateListing extends TeamsState {
  TeamsStateListing({
    this.query,
    this.teams,
    this.errors,
    bool isWaiting,
  }) : super(isWaiting: isWaiting);

  final TeamsQuery query;
  final List<Team> teams;
  final List<ApiError> errors;

  String toString() => "Listing teams";

  @override
  List<Object> get props => [query, teams, errors, isWaiting];
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

  @override
  List<Object> get props => [team, teamEdited, errors, isWaiting];
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

  @override
  List<Object> get props => [team, errors, isWaiting];
}
