import 'package:crowdproj/modules/teams/ITeamsService.dart';
import 'package:crowdproj/modules/teams/TeamsServiceRestHelper.dart';
import 'package:crowdproj_models/api.dart';
import 'package:crowdproj_models/api/team_api.dart';
import 'package:crowdproj_models/model/api_response_team_save.dart';
import 'package:crowdproj_models/model/profile.dart';
//import 'package:crowdproj_models/model/team.dart';
import 'package:dio/dio.dart';

import 'models/Team.dart' as local;
import 'models/Profile.dart' as local;
import 'models/ApiResponse.dart' as local;



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
  Future<local.ApiResponseTeamSave> saveTeam(local.Team team) async {
    final webRes = await _api.addTeam(team.toExchange());
    final res = webRes.data as ApiResponseTeamSave;
    return TeamsServiceRestHelper.fromApiResponseTeamSave(res);
  }

  @override
  Future<local.ApiResponseTeamGet> getTeam(String teamId) async {
    final webRes = await _api.getTeamById(teamId);
    final res = webRes.data;
    return TeamsServiceRestHelper.fromApiResponseTeamGet(res);
  }
}
