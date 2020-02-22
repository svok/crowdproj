import 'package:crowdproj/api/ITeamsService.dart';
import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:crowdproj/api/rest/TeamsServiceRestHelper.dart';
import 'package:crowdproj_models/api.dart';
import 'package:crowdproj_models/api/team_api.dart';
import 'package:dio/dio.dart';

import '../models/Team.dart' as local;
import '../models/Profile.dart' as local;
import '../models/ApiResponse.dart' as local;

class TeamsServiceRest extends ITeamsService {
  String basePath;
  CrowdprojModels _models;
  TeamApi _api;

  TeamsServiceRest({this.basePath}) : super() {
    BaseOptions _options = new BaseOptions(
      baseUrl: basePath,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio _dio = Dio(_options);
    _models = CrowdprojModels(dio: _dio);
    _api = _models.getTeamApi();
  }

  @override
  Future<local.ApiResponseTeam> saveTeam(local.Team team) async {
    final webRes = await _api.addTeam(TeamsServiceRestHelper.toTeam(team));
    final res = webRes.data;
    final localRes = TeamsServiceRestHelper.fromApiResponseTeam(res);
    if (localRes?.status == local.ApiResponseStatuses.success) {
      notifyListeners();
    }
    return localRes;
  }

  @override
  Future<local.ApiResponseTeam> getTeam(String teamId) async {
    final webRes = await _api.getTeamById(teamId);
    final res = webRes.data;
    return TeamsServiceRestHelper.fromApiResponseTeam(res);
  }

  Future<local.ApiResponseTeam> getTeams(TeamsQuery query) async {
    final webRes = await _api.getUserTeams(
      status: query.statuses.map((status) => TeamsServiceRestHelper.toStatus(status)),
      tags: query.tagIds,
    );
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
}
