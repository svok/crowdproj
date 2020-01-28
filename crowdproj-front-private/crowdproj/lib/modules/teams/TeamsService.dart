import 'package:crowdproj_models/api.dart';
import 'package:crowdproj_models/api/team_api.dart';
import 'package:crowdproj_models/model/api_response_team_save.dart';
import 'package:crowdproj_models/model/profile.dart';
//import 'package:crowdproj_models/model/team.dart';
import 'package:dio/dio.dart';

import 'models/Team.dart' as local;
import 'models/Profile.dart' as local;
import 'models/ApiResponse.dart' as local;



class TeamsService {
  String basePath;
  CrowdprojModels _models;
  TeamApi _api;

  TeamsService({this.basePath}) : super() {
    BaseOptions _options = new BaseOptions(
      baseUrl: basePath,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio _dio = Dio(_options);
    _models = CrowdprojModels(dio: _dio);
    _api = _models.getTeamApi();
  }

  Future<local.ApiResponseTeamSave> saveTeam(local.Team team) async {
//    await _api.addTeam(team.toExchange());
    return local.ApiResponseTeamSave(
      status: local.ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }

  Future<local.ApiResponseTeamGet> getTeam(String teamId) async {
//    return await _api.getTeamById(teamId).then((value) => value.data.data);
    print("getTeam: request");
    return local.ApiResponseTeamGet(
      team: local.Team(
        id: "some-id-1",
        name: "Some team",
        summary: "Some team object for testing purposes",
        description: "# Some team\n\nSome team description",
        owner: local.Profile(
          id: "some-profile-1",
          lName: "Johns",
          fName: "John",
          mName: "J",
          email: "john@johns.com",
          phone: "+1 404 500 500 404",
        ),
        visibility: local.TeamVisibility.public,
        status: local.TeamStatus.active,
        joinability: local.TeamJoinability.byUser,
      ),
      status: local.ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }
}
