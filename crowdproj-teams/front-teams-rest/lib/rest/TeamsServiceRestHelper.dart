import 'package:crowdproj_teams_models/models/ApiResponse.dart' as local;
import 'package:crowdproj_teams_models/models/Profile.dart' as local;
import 'package:crowdproj_teams_models/models/Team.dart' as local;
import 'package:crowdproj_teams_models/models/TeamVisibility.dart' as local;
import 'package:crowdproj_teams_models/models/TeamJoinability.dart' as local;
import 'package:crowdproj_teams_models/models/TeamStatus.dart' as local;

import 'package:generated_models_teams/model/api_response_status.dart'
    as remote;
import 'package:generated_models_teams/model/profile.dart' as remote;
import 'package:generated_models_teams/model/team.dart' as remote;
import 'package:generated_models_teams/model/api_error.dart' as remote;
import 'package:generated_models_teams/model/api_response.dart' as remote;
import 'package:generated_models_teams/model/api_response_team.dart' as remote;
import 'package:generated_models_teams/model/team_joinability.dart' as remote;
import 'package:generated_models_teams/model/team_status.dart' as remote;
import 'package:generated_models_teams/model/team_visibility.dart' as remote;

extension RemoteErrorLevels on String {
  local.ErrorLevels toLocal() =>
      local.ErrorLevels.values.firstWhere(
              (e) => e.toString().toLowerCase() == toLowerCase(),
          orElse: () => null); //return null if not found
}

extension TimeParse on String {
  DateTime toDateTime() => DateTime.tryParse(this);
}

extension RemoteApiResponseTeam on remote.ApiResponseTeam {
  local.ApiResponseTeam toLocal() => local.ApiResponseTeam(
        teams: data?.map((remoteTeam) => remoteTeam?.toLocal())?.skipWhile((value) => value == null),
        status: status.toLocal(),
        errors: errors.map((el) => el.toLocal()),
        timeRequested: timeReceived?.toDateTime(),
        timeFinished: timeFinished?.toDateTime(),
      );
}

extension RemoteApiResponseStatus on remote.ApiResponseStatus {
  local.ApiResponseStatuses toLocal() {
    switch (this) {
      case remote.ApiResponseStatus.responseOk:
        return local.ApiResponseStatuses.success;
      case remote.ApiResponseStatus.responseError:
        return local.ApiResponseStatuses.error;
      default:
        return null;
    }
  }
}

extension RemoteProfile on remote.Profile {
  local.Profile toLocal() => local.Profile(
        id: id,
        alias: alias,
        fName: fName,
        lName: lName,
        mName: mName,
        phone: phone,
        email: email,
      );
}

extension RemoteTeamVisibility on remote.TeamVisibility {
  local.TeamVisibility toLocal() {
    switch (this) {
      case remote.TeamVisibility.teamGroupOnly:
        return local.TeamVisibility.groupOnly;
      case remote.TeamVisibility.teamMembersOnly:
        return local.TeamVisibility.membersOnly;
      case remote.TeamVisibility.teamPublic:
        return local.TeamVisibility.public;
      case remote.TeamVisibility.teamRegisteredOnly:
        return local.TeamVisibility.registeredOnly;
      default:
        null;
    }
  }
}

extension LocalProfile on local.Profile {
  remote.Profile toRemote() => toRemoteBuilder().build();

  remote.ProfileBuilder toRemoteBuilder() => remote.ProfileBuilder()
    ..id = id
    ..alias = alias
    ..fName = fName
    ..lName = lName
    ..mName = mName
    ..email = email
    ..phone = phone;
}

extension LocalTeamVisibility on local.TeamVisibility {
  remote.TeamVisibility toRemote() {
    switch (this) {
      case local.TeamVisibility.groupOnly:
        return remote.TeamVisibility.teamGroupOnly;
      case local.TeamVisibility.membersOnly:
        return remote.TeamVisibility.teamMembersOnly;
      case local.TeamVisibility.public:
        return remote.TeamVisibility.teamPublic;
      case local.TeamVisibility.registeredOnly:
        return remote.TeamVisibility.teamRegisteredOnly;
      default:
        null;
    }
  }
}

extension RemoteTeamJoinability on remote.TeamJoinability {
  local.TeamJoinability toLocal() {
    switch (this) {
      case remote.TeamJoinability.byMember:
        return local.TeamJoinability.byMember;
      case remote.TeamJoinability.byOwner:
        return local.TeamJoinability.byOwner;
      case remote.TeamJoinability.byUser:
        return local.TeamJoinability.byUser;
      default:
        return null;
    }
  }
}

extension LocalTeamJoinability on local.TeamJoinability {
  remote.TeamJoinability toRemote() {
    switch (this) {
      case local.TeamJoinability.byUser:
        return remote.TeamJoinability.byUser;
      case local.TeamJoinability.byOwner:
        return remote.TeamJoinability.byOwner;
      case local.TeamJoinability.byMember:
        return remote.TeamJoinability.byMember;
    }
  }
}

extension RemoteTeamStatus on remote.TeamStatus {
  local.TeamStatus toLocal() {
    switch (this) {
      case remote.TeamStatus.active:
        return local.TeamStatus.active;
      case remote.TeamStatus.closed:
        return local.TeamStatus.closed;
      case remote.TeamStatus.deleted:
        return local.TeamStatus.deleted;
      case remote.TeamStatus.pending:
        return local.TeamStatus.pending;
      default:
        return null;
    }
  }
}

extension LocalTeamStatus on local.TeamStatus {
  remote.TeamStatus toRemote() {
    switch (this) {
      case local.TeamStatus.active:
        return remote.TeamStatus.active;
      case local.TeamStatus.closed:
        return remote.TeamStatus.closed;
      case local.TeamStatus.deleted:
        return remote.TeamStatus.deleted;
      case local.TeamStatus.pending:
        return remote.TeamStatus.pending;
      default:
        return null;
    }
  }
}

extension LocalTeam on local.Team {
  remote.TeamBuilder toRemoteBuilder() => remote.TeamBuilder()
    ..id = id
    ..name = name
    ..summary = summary
    ..description = description
    ..owner = owner?.toRemoteBuilder()
    ..visibility = visibility?.toRemote()
    ..joinability = joinability?.toRemote()
    ..status = status?.toRemote();

  remote.Team toRemote() => toRemoteBuilder().build();
}

extension RemoteTeam on remote.Team {
  local.Team toLocal() => local.Team(
        id: id,
        name: name,
        summary: summary,
        description: description,
        owner: owner?.toLocal(),
        visibility: visibility?.toLocal(),
        joinability: joinability?.toLocal(),
        status: status?.toLocal(),
      );
}

extension RemoteApiError on remote.ApiError {
  local.ApiError toLocal() => local.ApiError(
          code: code,
          field: field,
          message: message,
          description: description,
          level: level?.toLocal(),
        );
}
