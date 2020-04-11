

import 'package:crowdproj_teams_models/models/Team.dart';

class TeamViewEvent {}

class TeamViewEventUpdate extends TeamViewEvent {}
class TeamViewEventInvite extends TeamViewEvent {}
class TeamViewEventJoin extends TeamViewEvent {}
class TeamViewEventApply extends TeamViewEvent {}
class TeamViewEventLeave extends TeamViewEvent {}
class TeamViewEventUnapply extends TeamViewEvent {}
class TeamViewEventAcceptInvitation extends TeamViewEvent {}
class TeamViewEventDenayInvitation extends TeamViewEvent {}

class TeamViewEventRead extends TeamViewEvent{
  TeamViewEventRead({
    this.teamId,
    this.team,
  }) : super();
  final String teamId;
  final Team team;
}
