import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/modules/team/update/TeamUpdateEvent.dart';

class TeamUpdateEventChange extends TeamUpdateEvent {

  TeamUpdateEventChange(this.team): super();
  Team team;
}
