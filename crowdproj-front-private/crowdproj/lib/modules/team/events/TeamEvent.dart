import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/modules/team/states/TeamState.dart';
import 'package:equatable/equatable.dart';

import '../TeamBloc.dart';

abstract class TeamEvent extends Equatable {
  TeamEvent({this.team}): super();

  final Team team;
  Stream<TeamState> handle(TeamBloc TeamBloc);
}
