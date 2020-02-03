import 'package:crowdproj/modules/team/states/TeamState.dart';

import '../TeamBloc.dart';

abstract class TeamEvent {

  Stream<TeamState> handle(TeamBloc TeamBloc);
}
