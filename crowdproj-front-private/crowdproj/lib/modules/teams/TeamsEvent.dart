import 'models/Team.dart';

abstract class TeamsEvent {}

class TeamsEventViewRequested extends TeamsEvent {
  TeamsEventViewRequested({
    this.teamId,
  }) : super();

  final String teamId;
}

class TeamsEventSaveRequested extends TeamsEvent {
  TeamsEventSaveRequested({
    this.team,
  }) : super();

  final Team team;
}

class TeamsEventEditRequested extends TeamsEvent {
  TeamsEventEditRequested({
    this.team,
  }) : super();

  final Team team;
}
