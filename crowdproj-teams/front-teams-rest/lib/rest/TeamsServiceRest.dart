import 'package:generated_models_teams/api.dart';
import 'package:generated_models_teams/api/team_api.dart';
import 'package:generated_models_teams/model/api_query_team_find.dart';
import 'package:generated_models_teams/model/api_query_team_get.dart';
import 'package:generated_models_teams/model/api_query_team_save.dart';
import 'package:crowdproj_teams_models/ITeamsService.dart';

import 'package:crowdproj_teams_models/models/TeamsQuery.dart';
import 'package:crowdproj_teams_models/models/Team.dart' as local;
import 'package:crowdproj_teams_models/models/Profile.dart' as local;
import 'package:crowdproj_teams_models/models/ApiResponse.dart' as local;

import 'TeamsServiceRestHelper.dart';

import 'package:dio/dio.dart';

class TeamsServiceRest extends ITeamsService {
  String basePath;
  GeneratedModelsTeams _models;
  TeamApi _api;

  TeamsServiceRest({this.basePath}) : super() {
    BaseOptions _options = new BaseOptions(
      baseUrl: basePath,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio _dio = Dio(_options);
    _models = GeneratedModelsTeams(dio: _dio);
    _api = _models.getTeamApi();
  }

  @override
  Future<local.ApiResponseTeam> saveTeam(local.Team team) async {
    final webRes = await _api.addTeam(ApiQueryTeamSave((builder) => builder
        ..data = TeamsServiceRestHelper.toTeamBuilder(team)
    ));
    final res = webRes.data;
    final localRes = TeamsServiceRestHelper.fromApiResponseTeam(res);
    if (localRes?.status == local.ApiResponseStatuses.success) {
      notifyListeners();
    }
    return localRes;
  }

  @override
  Future<local.ApiResponseTeam> getTeam(String teamId) async {
      final webRes = await _api.getTeam(ApiQueryTeamGet((builder) => builder.teamId = teamId));
    final res = webRes.data;
    return TeamsServiceRestHelper.fromApiResponseTeam(res);
  }

  Future<local.ApiResponseTeam> getTeams(TeamsQuery query) async {
    final webRes = await _api.findTeams(ApiQueryTeamFind((builder) => builder
        ..limit = query.limit
        ..offset = query.offset
//      ..s = query.statuses.map((status) => TeamsServiceRestHelper.toStatus(status)),
//      tags: query.tagIds,
    ));
    final res = webRes.data;
    return TeamsServiceRestHelper.fromApiResponseTeam(res);
  }

  @override
  Future<local.ApiResponseTeam> applyMembership(String teamId) {
    // TODO: implement applyMembership
    throw UnimplementedError();
  }

  @override
  Future<local.ApiResponseTeam> joinMembership(String teamId) {
    // TODO: implement joinMembership
    throw UnimplementedError();
  }

  @override
  Future<local.ApiResponseTeam> acceptInvitation(String teamId) {
    // TODO: implement acceptInvitation
    throw UnimplementedError();
  }

  @override
  Future<local.ApiResponseTeam> denyInvitation(String teamId) {
    // TODO: implement denytInvitation
    throw UnimplementedError();
  }

  @override
  Future<local.ApiResponseTeam> invite(String teamId, String profileId) {
    // TODO: implement invite
    throw UnimplementedError();
  }

  @override
  Future<local.ApiResponseTeam> leaveTeam(String teamId) {
    // TODO: implement leaveTeam
    throw UnimplementedError();
  }

  @override
  Future<local.ApiResponseTeam> unapplyMembership(String teamId) {
    // TODO: implement unapplyMembership
    throw UnimplementedError();
  }
}
