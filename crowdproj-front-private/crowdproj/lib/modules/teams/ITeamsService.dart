import 'package:crowdproj_models/api.dart';
import 'package:crowdproj_models/api/team_api.dart';
import 'package:crowdproj_models/model/api_response_team_save.dart';
import 'package:crowdproj_models/model/profile.dart';
//import 'package:crowdproj_models/model/team.dart';
import 'package:dio/dio.dart';

import 'models/Team.dart' as local;
import 'models/Profile.dart' as local;
import 'models/ApiResponse.dart' as local;

abstract class ITeamsService {
  Future<local.ApiResponseTeamSave> saveTeam(local.Team team);
  Future<local.ApiResponseTeamGet> getTeam(String teamId);
}
