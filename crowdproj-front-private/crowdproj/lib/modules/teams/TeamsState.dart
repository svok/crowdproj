import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:equatable/equatable.dart';

class TeamsState extends Equatable {
  TeamsState({
    this.query,
    this.teams,
    this.errors,
    this.hasReachedMax = true,
    this.isWaiting = false,
  }) : super();

  final TeamsQuery query;
  final List<Team> teams;
  final List<ApiError> errors;
  final bool isWaiting;
  final bool hasReachedMax;

  int get offset => query?.offset ?? 0;
  int get limit => query?.limit ?? 0;
  int get length => teams?.length ?? 0;
  DateTime get timeVersion => query.onDate;

  Team getTeam(int index) => teams[index];

  TeamsState clone({
    TeamsQuery query,
    List<Team> teams,
    List<ApiError> errors,
    bool hasReachedMax,
    bool isWaiting,
  }) => TeamsState(
    query: query ?? this.query,
    teams: teams ?? this.teams,
    errors: errors ?? this.errors,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    isWaiting: isWaiting ?? this.isWaiting,
  );

  @override
  List<Object> get props => [isWaiting];
}
