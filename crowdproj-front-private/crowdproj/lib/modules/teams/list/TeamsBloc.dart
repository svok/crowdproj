import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crowdproj/api/models/TeamRelations.dart';
import 'package:crowdproj/api/models/TeamStatus.dart';
import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/modules/teams/list/TeamsEventInit.dart';
import 'package:flutter/material.dart';

import 'TeamsEvent.dart';
import 'TeamsEventReadNext.dart';
import 'TeamsEventUpdate.dart';
import 'TeamsState.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc(this.context, this.teamRelation) : super();

  final TeamRelations teamRelation;
  final BuildContext context;
  static const BATCH_SIZE = 20;

  TeamsQuery buildQuery({
    DateTime onDate,
    int offset,
    int limit,
    List<String> tagIds,
    List<TeamStatus> statuses,
    List<TeamRelations> relations,
  }) =>
      TeamsQuery(
        relation: teamRelation,
        onDate: onDate,
        offset: offset,
        limit: limit,
        tagIds: tagIds,
        statuses: statuses,
        relations: relations,
      );

  @override
  TeamsState get initialState => TeamsState();

  @override
  Stream<TeamsState> mapEventToState(TeamsEvent event) async* {
    switch (event.runtimeType) {
      case TeamsEventInit:
        yield* _init(event);
        break;
      case TeamsEventReadNext:
        yield* _readNext(event);
        break;
      case TeamsEventUpdate:
        yield* _update(event);
        break;
      default:
        yield TeamsState();
    }
    print("TEAMS BLOC EVENT: $event");
  }

  Stream<TeamsState> _init(TeamsEventInit event) async* {
    final query = buildQuery(
      offset: 0,
      limit: BATCH_SIZE,
    );
    yield TeamsState(
      query: query,
      teams: [],
      errors: [],
      isWaiting: true,
    );
    final result = await AppSession.get.teamsService.getTeams(query);
    yield TeamsState(
      query: query,
      teams: result.teams,
      errors: result.errors,
      hasReachedMax: result.teams.length < query.limit,
    );
  }

  Stream<TeamsState> _readNext(TeamsEventReadNext event) async* {
    yield state.copyWith(isWaiting: true);

    final query = buildQuery(
      onDate: state.timeVersion,
      offset: state.offset + state.limit,
      limit: event.amount,
    );
    final result = await AppSession.get.teamsService.getTeams(query);
    final newTeams = (state?.teams ?? []) + (result?.teams ?? []);
    yield TeamsState(
      query: query,
      teams: newTeams,
      errors: result.errors,
      hasReachedMax: result.teams.length < query.limit,
    );
  }

  Stream<TeamsState> _update(TeamsEventUpdate event) async* {
    yield state.copyWith(isWaiting: true);

    final query = buildQuery(
      offset: 0,
      limit: state.teams?.length,
    );
    final _service = AppSession.get.teamsService;
    final result = await _service.getTeams(query);
    final newTeams = result?.teams ?? [];
    _service.isUptodate = true;
    yield TeamsState(
      query: query,
      teams: newTeams,
      errors: result.errors,
      hasReachedMax: result.teams.length < query.limit,
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('TeamsBloc - Error\'s occured: $error, $stackTrace');
  }
}
