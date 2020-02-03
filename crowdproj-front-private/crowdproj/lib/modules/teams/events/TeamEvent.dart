import 'package:crowdproj/modules/teams/TeamBloc.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';

abstract class TeamEvent {

  Stream<TeamsState> handle(TeamBloc TeamBloc);
}
