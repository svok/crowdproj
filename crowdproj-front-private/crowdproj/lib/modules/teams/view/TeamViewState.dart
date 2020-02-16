import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:equatable/equatable.dart';

class TeamViewState extends Equatable {
  TeamViewState({
    this.teamId,
    this.errors,
    this.team,
    this.isWaiting = false,
  }) : super();

  final String teamId;
  final Team team;
  final bool isWaiting;
  final List<ApiError> errors;

  String toString() => "Viewing team ${team?.id}";

  @override
  List<Object> get props => [team, errors, isWaiting];

  TeamViewState copyWith({
    String teamId,
    Team team,
    bool isWaiting,
    List<ApiError> errors,
  }) =>
      TeamViewState(
        teamId: teamId ?? this.teamId,
        team: team ?? this.team,
        isWaiting: isWaiting ?? this.isWaiting,
        errors: errors ?? this.errors,
      );
}
