import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:equatable/equatable.dart';

class TeamsState extends Equatable {
  TeamsState({
    this.query,
    this.teams,
    this.errors,
    this.isWaiting = false,
  }) : super();

  final TeamsQuery query;
  final List<Team> teams;
  final List<ApiError> errors;
  final bool isWaiting;

  Team getTeam(int index) => teams[index];

  TeamsRangeStatus checkRange(int index) {
    if (query == null || teams == null) return TeamsRangeStatus.empty;
    if (index < 0) return TeamsRangeStatus.noBefore;
    if (index < query.offset) return TeamsRangeStatus.beforeBuffer;
    if (index < query.offset + teams.length) return TeamsRangeStatus.withinBuffer;
    if (teams.length < query.limit) return TeamsRangeStatus.noAfter;
    return TeamsRangeStatus.afterBuffer;
  }

  @override
  List<Object> get props => [isWaiting];
}

enum TeamsRangeStatus {
  withinBuffer,
  beforeBuffer,
  afterBuffer,
  noBefore,
  noAfter,
  empty,
}
