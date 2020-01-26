import 'package:crowdproj_models/api.dart';
import 'package:crowdproj_models/api/team_api.dart';
import 'package:crowdproj_models/model/team.dart';
import 'package:dio/dio.dart';

import 'models/Team.dart' as local;

class TeamsService {

  String basePath;
  CrowdprojModels _models;
  TeamApi _api;

  TeamsService({this.basePath}): super() {
    BaseOptions _options = new BaseOptions(
      baseUrl: basePath,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio _dio = Dio(_options);
    _models = CrowdprojModels(dio: _dio);
    _api = _models.getTeamApi();
  }

  Future<void> saveTeam(local.Team team) async {
    await _api.addTeam(team.toExchange());
  }

  Future<Response<Team>> getTeam(String teamId) async {
    return await _api.getTeamById(teamId);
  }

}
