import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';

import 'TeamState.dart';

class TeamStateViewing extends TeamState {
  TeamStateViewing({
    this.team,
    this.errors,
    bool isWaiting,
  }) : super(isWaiting: isWaiting);
  final Team team;
  final List<ApiError> errors;

  String toString() => "Viewing team ${team?.id}";

  @override
  List<Object> get props => [team, errors, isWaiting];
}
