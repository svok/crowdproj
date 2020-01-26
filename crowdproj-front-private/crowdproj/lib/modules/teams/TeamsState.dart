import 'models/Team.dart';

abstract class TeamsState {

}

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
  }): super();

  Team team;
  Team teamEdited;

  String toString() => "Editing team ${team.id}";
}

class TeamsStateViewing extends TeamsState {
  TeamsStateViewing({
    this.team,
}): super();
  Team team;

  String toString() => "Viewing team ${team.id}";
}