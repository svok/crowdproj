import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';

import 'TeamState.dart';

class TeamStateViewing extends TeamState {
  TeamStateViewing({
    Team team,
    this.errors,
    bool isWaiting,
  }) : super(team: team, isWaiting: isWaiting);
  final List<ApiError> errors;

  String toString() => "Viewing team ${team?.id}";

  @override
  List<Object> get props => [team, errors, isWaiting];
}
