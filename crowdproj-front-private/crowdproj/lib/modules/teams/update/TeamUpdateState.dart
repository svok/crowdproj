import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:equatable/equatable.dart';

class TeamUpdateState extends Equatable {
  TeamUpdateState({
    this.teamId,
    this.errors,
    this.team,
    this.teamUpdated,
    this.isWaiting = false,
  }) : super();

  final String teamId;
  final Team team;
  final Team teamUpdated;
  final bool isWaiting;
  final List<ApiError> errors;

  String toString() =>
      teamId == null ? "Creating a team" : "Editing team ${team?.id}";

  TeamUpdateState copyWith({
    String teamId,
    Team team,
    Team teamUpdated,
    bool isWaiting,
    List<ApiError> errors,
  }) =>
      TeamUpdateState(
        teamId: teamId ?? this.teamId,
        team: team ?? this.team,
        teamUpdated: teamUpdated ?? this.teamUpdated,
        isWaiting: isWaiting ?? this.isWaiting,
        errors: errors ?? this.errors,
      );

  @override
  List<Object> get props => [teamId, team, teamUpdated, errors, isWaiting];
}
