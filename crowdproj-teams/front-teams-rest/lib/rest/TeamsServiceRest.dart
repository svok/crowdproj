import 'package:generated_models_teams/api.dart';
import 'package:generated_models_teams/api/team_api.dart';
import 'package:generated_models_teams/model/rest_query_team_get.dart';
import 'package:generated_models_teams/model/rest_query_team_find.dart';
import 'package:generated_models_teams/model/rest_query_team_save.dart';
import 'package:generated_models_teams/model/rest_response_team.dart';

import 'TeamsServiceRestHelper.dart';
import 'package:crowdproj_teams_models/ITeamsService.dart';

import 'package:crowdproj_teams_models/models/TeamsQuery.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:crowdproj_teams_models/models/ApiResponse.dart';

import 'package:dio/dio.dart';

class TeamsServiceRest extends ITeamsService {
  String basePath;
  GeneratedModelsTeams _models;
  TeamApi _api;

  TeamsServiceRest({this.basePath}) : super() {
    BaseOptions _options = new BaseOptions(
      baseUrl: basePath,
//      connectTimeout: 50000,
//      receiveTimeout: 30000,
    );
    Dio _dio = Dio(_options);
    _models = GeneratedModelsTeams(dio: _dio);
    _api = _models.getTeamApi();
  }

  @override
  Future<ApiResponseTeam> saveTeam(Team team) async {
    final webRes = team?.id == null
        ? await _api.addTeam(RestQueryTeamSave(
            (builder) => builder..data = team.toRemoteBuilder()))
        : await _api.updateTeam(RestQueryTeamSave(
            (builder) => builder..data = team.toRemoteBuilder()));
    final res = webRes.data;
    final localRes = res.toLocal();
//    if (localRes?.status == ApiResponseStatuses.success) {
    notifyListeners();
//    }
    return localRes;
  }

  @override
  Future<ApiResponseTeam> getTeam(String teamId) async {
    final webRes = await _api
        .getTeam(RestQueryTeamGet((builder) => builder.teamId = teamId));
    final res = webRes.data;
    return res.toLocal();
  }

  Future<ApiResponseTeam> getTeams(TeamsQuery query) async {
    Response<RestResponseTeam> webRes;
    try {
      webRes = await _api.findTeams(RestQueryTeamFind((builder) => builder
            ..limit = query.limit
            ..offset = query.offset
//      ..s = query.statuses.map((status) => TeamsServiceRestHelper.toStatus(status)),
//      tags: query.tagIds,
          ));
      print("getTeams got a result: ${webRes}");
      print("converted to ${webRes.data?.toLocal()}");
      return webRes.data?.toLocal();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return ApiResponseTeam(
          status: ApiResponseStatuses.error,
          errors: List<ApiError>()
            ..add(ApiError(
              code: webRes?.statusCode?.toString() ?? "unknown-error",
              field: "",
              message: e.toString(),
              description: "Server error",
              level: ErrorLevels.fatal,
            )));
    }
  }

  @override
  Future<ApiResponseTeam> applyMembership(String teamId) {
    // TODO: implement applyMembership
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseTeam> joinMembership(String teamId) {
    // TODO: implement joinMembership
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseTeam> acceptInvitation(String teamId) {
    // TODO: implement acceptInvitation
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseTeam> denyInvitation(String teamId) {
    // TODO: implement denytInvitation
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseTeam> invite(String teamId, String profileId) {
    // TODO: implement invite
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseTeam> leaveTeam(String teamId) {
    // TODO: implement leaveTeam
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseTeam> unapplyMembership(String teamId) {
    // TODO: implement unapplyMembership
    throw UnimplementedError();
  }
}
