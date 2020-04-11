
import 'package:crowdproj_teams_models/models/Team.dart';

import 'TeamUpdateEvent.dart';

class TeamUpdateEventChange extends TeamUpdateEvent {

  TeamUpdateEventChange(this.team): super();
  Team team;
}
