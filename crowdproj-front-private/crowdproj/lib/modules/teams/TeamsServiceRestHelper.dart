import 'package:crowdproj/modules/teams/models/ApiResponse.dart' as local;
import 'package:crowdproj/modules/teams/models/Team.dart';
import 'package:crowdproj_models/model/api_error.dart' as remote;
import 'package:crowdproj_models/model/api_response.dart' as remote;
import 'package:crowdproj_models/model/api_response_team_get.dart' as remote;
import 'package:crowdproj_models/model/api_response_team_save.dart' as remote;

class TeamsServiceRestHelper {
  static local.ApiResponseTeamSave fromApiResponseTeamSave(
          remote.ApiResponseTeamSave remote) =>
      local.ApiResponseTeamSave(
        team: Team.fromExchange(remote.data),
        status: fromResponseStatus(remote.status),
        errors: remote.errors.map((el) => fromApiError(el)),
        timeRequested: DateTime.tryParse(remote.timeReceived),
        timeFinished: DateTime.tryParse(remote.timeFinished),
      );

  static local.ApiResponseTeamGet fromApiResponseTeamGet(
      remote.ApiResponseTeamGet remote) =>
      local.ApiResponseTeamGet(
        team: Team.fromExchange(remote.data),
        status: fromResponseStatus(remote.status),
        errors: remote.errors.map((el) => fromApiError(el)),
        timeRequested: DateTime.tryParse(remote.timeReceived),
        timeFinished: DateTime.tryParse(remote.timeFinished),
      );

  static local.ApiResponseStatuses fromResponseStatus(String str) =>
      local.ApiResponseStatuses.values.firstWhere(
          (e) => e.toString().toLowerCase() == str.toLowerCase(),
          orElse: () => null); //return null if not found

  static local.ErrorLevels fromErrorLevels(String str) =>
      local.ErrorLevels.values.firstWhere(
          (e) => e.toString().toLowerCase() == str.toLowerCase(),
          orElse: () => null); //return null if not found

  static local.ApiError fromApiError(remote.ApiError value) => local.ApiError(
        code: value.code,
        field: value.field,
        message: value.message,
        description: value.description,
        level: fromErrorLevels(value.level),
      );

}
