import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';

abstract class TeamEvent {

  Stream<TeamsState> handle(TeamsBloc teamsBloc);
}
