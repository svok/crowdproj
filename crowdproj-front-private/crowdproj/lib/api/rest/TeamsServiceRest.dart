import 'package:crowdproj/api/ITeamsService.dart';
import 'package:crowdproj/api/rest/TeamsServiceRestHelper.dart';
import 'package:crowdproj_models/api.dart';
import 'package:crowdproj_models/api/team_api.dart';
import 'package:dio/dio.dart';

import '../models/Team.dart' as local;
import '../models/Profile.dart' as local;
import '../models/ApiResponse.dart' as local;

class TeamsServiceRest implements ITeamsService {
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
    return TeamsServiceRestHelper.fromApiResponseTeam(res);
  }

  @override
  Future<local.ApiResponseTeam> getTeam(String teamId) async {
    final webRes = await _api.getTeamById(teamId);
    final res = webRes.data;
    return TeamsServiceRestHelper.fromApiResponseTeam(res);
  }
}
