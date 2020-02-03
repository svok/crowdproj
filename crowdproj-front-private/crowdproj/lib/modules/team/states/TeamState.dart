import 'package:crowdproj/api/models/Team.dart';
import 'package:equatable/equatable.dart';

abstract class TeamState extends Equatable {
  TeamState({
    this.team,
    this.isWaiting = false,
  }): super();
  final Team team;
  final bool isWaiting;
}
