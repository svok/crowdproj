import 'TeamsServiceRestHelper.dart';
import 'package:crowdproj_teams_models/ITeamsService.dart';

import 'package:generated_models_teams/api.dart' as remote;
import 'package:generated_models_teams/api/team_api.dart' as remote;
import 'package:generated_models_teams/model/api_query_team_find.dart' as remote;
import 'package:generated_models_teams/model/api_query_team_get.dart' as remote;
import 'package:generated_models_teams/model/api_query_team_save.dart' as remote;
import 'package:generated_models_teams/model/api_response_team.dart' as remote;

import 'package:crowdproj_teams_models/models/TeamsQuery.dart' as local;
import 'package:crowdproj_teams_models/models/Team.dart' as local;
import 'package:crowdproj_teams_models/models/Profile.dart' as local;
import 'package:crowdproj_teams_models/models/ApiResponse.dart' as local;


import 'package:dio/dio.dart';

class TeamsServiceRest extends ITeamsService {
  String basePath;
  remote.GeneratedModelsTeams _models;
  remote.TeamApi _api;

  TeamsServiceRest({this.basePath}) : super() {
    BaseOptions _options = new BaseOptions(
      baseUrl: basePath,
//      connectTimeout: 50000,
//      receiveTimeout: 30000,
    );
    Dio _dio = Dio(_options);
    _models = remote.GeneratedModelsTeams(dio: _dio);
    _api = _models.getTeamApi();
  }

  @override
  Future<local.ApiResponseTeam> saveTeam(local.Team team) async {
    final webRes = await _api.addTeam(remote.ApiQueryTeamSave((builder) => builder
        ..data = team.toRemoteBuilder()
    ));
    final res = webRes.data;
    final localRes = res.toLocal();
    if (localRes?.status == local.ApiResponseStatuses.success) {
      notifyListeners();
    }
    return localRes;
  }

  @override
  Future<local.ApiResponseTeam> getTeam(String teamId) async {
      final webRes = await _api.getTeam(remote.ApiQueryTeamGet((builder) => builder.teamId = teamId));
    final res = webRes.data;
    return res.toLocal();
  }

  Future<local.ApiResponseTeam> getTeams(local.TeamsQuery query) async {
    Response<remote.ApiResponseTeam> webRes;
    try {
      webRes = await _api.findTeams(
          remote.ApiQueryTeamFind((builder) =>
          builder
            ..limit = query.limit
            ..offset = query.offset
//      ..s = query.statuses.map((status) => TeamsServiceRestHelper.toStatus(status)),
//      tags: query.tagIds,
          ));
      print("getTeams got a result: ${webRes}");
      print("converted to ${webRes.data?.toLocal()}");
      return webRes.data?.toLocal();
    } catch(e, stacktrace) {
      print(e);
      print(stacktrace);
      return local.ApiResponseTeam(
        status: local.ApiResponseStatuses.error,
        errors: List<local.ApiError>()
            ..add(local.ApiError(
              code: webRes?.statusCode?.toString() ?? "unknown-error",
              field: "",
              message: e.toString(),
              description: "Server error",
              level: local.ErrorLevels.fatal,
            ))
      );
    }
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
