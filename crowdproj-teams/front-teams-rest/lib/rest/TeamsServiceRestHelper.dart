import 'package:crowdproj_teams_models/models/ApiResponse.dart' as local;
import 'package:crowdproj_teams_models/models/Profile.dart' as local;
import 'package:crowdproj_teams_models/models/Team.dart' as local;
import 'package:crowdproj_teams_models/models/TeamVisibility.dart' as local;
import 'package:crowdproj_teams_models/models/TeamJoinability.dart' as local;
import 'package:crowdproj_teams_models/models/TeamStatus.dart' as local;

import 'package:generated_models_teams/model/profile.dart' as remote;
import 'package:generated_models_teams/model/team.dart' as remote;
import 'package:generated_models_teams/model/api_error.dart' as remote;
import 'package:generated_models_teams/model/api_response.dart' as remote;
import 'package:generated_models_teams/model/api_response_team.dart' as remote;
import 'package:generated_models_teams/model/team_joinability.dart' as remote;
import 'package:generated_models_teams/model/team_status.dart' as remote;
import 'package:generated_models_teams/model/team_visibility.dart' as remote;

class TeamsServiceRestHelper {

//  static local.ApiSaveQuery fromApiSaveQuery(
//      remote.Api
//      );

  static local.ApiResponseTeam fromApiResponseTeam(
      remote.ApiResponseTeam remote) =>
      local.ApiResponseTeam(
        teams: remote.data.map((remoteTeam) => fromTeam(remoteTeam)),
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

  static local.ApiError fromApiError(remote.ApiError value) =>
      local.ApiError(
        code: value.code,
        field: value.field,
        message: value.message,
        description: value.description,
        level: fromErrorLevels(value.level),
      );

  static local.Team fromTeam(remote.Team team) =>
      local.Team(
        id: team.id,
        name: team.name,
        summary: team.summary,
        description: team.description,
        owner: fromProfile(team.owner),
        visibility: fromVisibility(team.visibility),
        joinability: fromJoinability(team.joinability),
        status: fromStatus(team.status),
      );

  static remote.Team toTeam(local.Team local) => toTeamBuilder(local).build();

  static remote.TeamBuilder toTeamBuilder(local.Team local) =>
      remote.TeamBuilder()
        ..id = local.id
        ..name = local.name
        ..summary = local.summary
        ..description = local.description
        ..owner = toProfileBuilder(local.owner)
        ..visibility = toVisibility(local.visibility)
        ..joinability = toJoinability(local.joinability)
        ..status = toStatus(local.status);

  static local.Profile fromProfile(remote.Profile profile) => local.Profile(
    id: profile.id,
    alias: profile.alias,
    fName: profile.fName,
    lName: profile.lName,
    mName: profile.mName,
    phone: profile.phone,
    email: profile.email,
  );

  static remote.Profile toProfile(local.Profile local) => toProfileBuilder(local).build();

  static remote.ProfileBuilder toProfileBuilder(local.Profile local) => remote.ProfileBuilder()
    ..id = local.id
    ..alias = local.alias
    ..fName = local.fName
    ..lName = local.lName
    ..mName = local.mName
    ..email = local.email
    ..phone = local.phone;


  static local.TeamVisibility fromVisibility(remote.TeamVisibility remote) =>
      local.TeamVisibility.values
          .firstWhere((e) =>
      e.toString().replaceAll("_", "").toLowerCase() ==
          remote.name.toLowerCase(),
          orElse: () => null); //return null if not found

  static remote.TeamVisibility toVisibility(local.TeamVisibility local) =>
      remote.TeamVisibility.values
          .firstWhere((e) =>
      e.toString().replaceAll("_", "").toLowerCase() ==
          local.toString().toLowerCase(),
          orElse: () => null); //return null if not found

  static local.TeamJoinability fromJoinability(remote.TeamJoinability remote) =>
      local.TeamJoinability.values
          .firstWhere((e) =>
      e.toString().replaceAll("_", "").toLowerCase() ==
          remote.name.toLowerCase(),
          orElse: () => null); //return null if not found

  static remote.TeamJoinability toJoinability(local.TeamJoinability local) =>
      remote.TeamJoinability.values
          .firstWhere((e) =>
      e.toString().replaceAll("_", "").toLowerCase() ==
          local.toString().toLowerCase(),
          orElse: () => null); //return null if not found

  static local.TeamStatus fromStatus(remote.TeamStatus remote) =>
      local.TeamStatus.values.firstWhere(
              (e) =>
          e.toString().replaceAll("_", "").toLowerCase() ==
              remote.name.toLowerCase(),
          orElse: () => null); //return null if not found

  static remote.TeamStatus toStatus(local.TeamStatus local) =>
      remote.TeamStatus.values.firstWhere(
              (e) =>
          e.toString().replaceAll("_", "").toLowerCase() ==
              local.toString().toLowerCase(),
          orElse: () => null); //return null if not found

}
