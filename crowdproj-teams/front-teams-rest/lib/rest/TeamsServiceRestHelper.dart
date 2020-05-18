import 'package:built_collection/built_collection.dart';
import 'package:crowdproj_teams_models/models/ApiResponse.dart';
import 'package:crowdproj_teams_models/models/Profile.dart';
import 'package:crowdproj_teams_models/models/ProfileStatus.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:crowdproj_teams_models/models/TeamAccess.dart' ;
import 'package:crowdproj_teams_models/models/TeamVisibility.dart' ;
import 'package:crowdproj_teams_models/models/TeamJoinability.dart' ;
import 'package:crowdproj_teams_models/models/TeamStatus.dart' ;

import 'package:generated_models_teams/model/rest_error.dart';
import 'package:generated_models_teams/model/rest_profile.dart';
import 'package:generated_models_teams/model/rest_profile_status.dart';
import 'package:generated_models_teams/model/rest_response_status.dart';
import 'package:generated_models_teams/model/rest_response_team.dart';
import 'package:generated_models_teams/model/rest_team.dart';
import 'package:generated_models_teams/model/rest_team_joinability.dart';
import 'package:generated_models_teams/model/rest_team_operations.dart';
import 'package:generated_models_teams/model/rest_team_status.dart';
import 'package:generated_models_teams/model/rest_team_visibility.dart';

extension RemoteErrorLevels on String {
  ErrorLevels toLocal() => ErrorLevels.values.firstWhere(
      (e) => e.toString().toLowerCase() == toLowerCase(),
      orElse: () => null); //return null if not found
}

extension TimeParse on String {
  DateTime toDateTime() => DateTime.tryParse(this);
}

extension RemoteApiResponseTeam on RestResponseTeam {
  ApiResponseTeam toLocal() => ApiResponseTeam(
        teams: data
            ?.map((remoteTeam) => remoteTeam?.toLocal())
//            ?.skipWhile((value) => value == null)
            ?.toList(),
        status: status.toLocal(),
        errors: errors?.map((el) => el.toLocal())?.toList(),
        timeRequested: timeReceived?.toDateTime(),
        timeFinished: timeFinished?.toDateTime(),
      );
}

extension RemoteApiResponseStatus on RestResponseStatus {
  ApiResponseStatuses toLocal() {
    switch (this) {
      case RestResponseStatus.responseOk:
        return ApiResponseStatuses.success;
      case RestResponseStatus.responseError:
        return ApiResponseStatuses.error;
      default:
        return null;
    }
  }
}

extension RemoteProfile on RestProfile {
  Profile toLocal() => Profile(
      id: id,
      alias: alias,
      fName: fName,
      lName: lName,
      mName: mName,
      phone: phone,
      email: email,
      status: profileStatus?.toLocal(),
  );
}

extension RemoteProfileStatus on RestProfileStatus {
  ProfileStatus toLocal() {
    switch(this) {
      case RestProfileStatus.profileActive: return ProfileStatus.active;
      case RestProfileStatus.profileClosed: return ProfileStatus.closed;
      case RestProfileStatus.profileDeleted: return ProfileStatus.deleted;
    }
  }
}

extension LocalProfileStatus on ProfileStatus {
  RestProfileStatus toRemote() {
    switch(this) {
      case ProfileStatus.active: return RestProfileStatus.profileActive;
      case ProfileStatus.closed: return RestProfileStatus.profileClosed;
      case ProfileStatus.deleted: return RestProfileStatus.profileDeleted;
    }
  }
}

extension RemoteTeamVisibility on RestTeamVisibility {
  TeamVisibility toLocal() {
    switch (this) {
      case RestTeamVisibility.teamGroupOnly:
        return TeamVisibility.groupOnly;
      case RestTeamVisibility.teamMembersOnly:
        return TeamVisibility.membersOnly;
      case RestTeamVisibility.teamPublic:
        return TeamVisibility.public;
      case RestTeamVisibility.teamRegisteredOnly:
        return TeamVisibility.registeredOnly;
      default:
        null;
    }
  }
}

extension LocalProfile on Profile {
  RestProfile toRemote() => toRemoteBuilder().build();

  RestProfileBuilder toRemoteBuilder() => RestProfileBuilder()
    ..id = id
    ..alias = alias
    ..fName = fName
    ..lName = lName
    ..mName = mName
    ..email = email
    ..phone = phone
    ..profileStatus = status.toRemote();
}

extension LocalTeamVisibility on TeamVisibility {
  RestTeamVisibility toRemote() {
    switch (this) {
      case TeamVisibility.groupOnly:
        return RestTeamVisibility.teamGroupOnly;
      case TeamVisibility.membersOnly:
        return RestTeamVisibility.teamMembersOnly;
      case TeamVisibility.public:
        return RestTeamVisibility.teamPublic;
      case TeamVisibility.registeredOnly:
        return RestTeamVisibility.teamRegisteredOnly;
      default:
        null;
    }
  }
}

extension RemoteTeamJoinability on RestTeamJoinability {
  TeamJoinability toLocal() {
    switch (this) {
      case RestTeamJoinability.byMember:
        return TeamJoinability.byMember;
      case RestTeamJoinability.byOwner:
        return TeamJoinability.byOwner;
      case RestTeamJoinability.byUser:
        return TeamJoinability.byUser;
      default:
        return null;
    }
  }
}

extension LocalTeamJoinability on TeamJoinability {
  RestTeamJoinability toRemote() {
    switch (this) {
      case TeamJoinability.byUser:
        return RestTeamJoinability.byUser;
      case TeamJoinability.byOwner:
        return RestTeamJoinability.byOwner;
      case TeamJoinability.byMember:
        return RestTeamJoinability.byMember;
    }
  }
}

extension RemoteTeamStatus on RestTeamStatus {
  TeamStatus toLocal() {
    switch (this) {
      case RestTeamStatus.active:
        return TeamStatus.active;
      case RestTeamStatus.closed:
        return TeamStatus.closed;
      case RestTeamStatus.deleted:
        return TeamStatus.deleted;
      case RestTeamStatus.pending:
        return TeamStatus.pending;
      default:
        return null;
    }
  }
}

extension LocalTeamStatus on TeamStatus {
  RestTeamStatus toRemote() {
    switch (this) {
      case TeamStatus.active:
        return RestTeamStatus.active;
      case TeamStatus.closed:
        return RestTeamStatus.closed;
      case TeamStatus.deleted:
        return RestTeamStatus.deleted;
      case TeamStatus.pending:
        return RestTeamStatus.pending;
      default:
        return null;
    }
  }
}

extension LocalTeam on Team {
  RestTeamBuilder toRemoteBuilder() => RestTeamBuilder()
    ..id = id
    ..name = name
    ..summary = summary
    ..description = description
    ..owner = owner?.toRemoteBuilder()
    ..visibility = visibility?.toRemote()
    ..joinability = joinability?.toRemote()
    ..status = status?.toRemote()
    ..cans = cans == null ? null : ListBuilder(cans.map((can) => can.toRemote()));
  RestTeam toRemote() => toRemoteBuilder().build();
}

extension RemoteTeamOperations on RestTeamOperations {
  TeamAccess toLocal() {
    switch(this) {
      case RestTeamOperations.acceptInvitation: return TeamAccess.ACCEPT_INVITATION;
      case RestTeamOperations.cancelInvitation: return TeamAccess.DENY_INVITATION;
      case RestTeamOperations.apply: return TeamAccess.APPLY;
      case RestTeamOperations.invite: return TeamAccess.INVITE;
      case RestTeamOperations.join: return TeamAccess.JOIN;
      case RestTeamOperations.leave: return TeamAccess.LEAVE;
      case RestTeamOperations.unapply: return TeamAccess.UNAPPLY;
      case RestTeamOperations.update: return TeamAccess.UPDATE;
    }
    return null;
  }
}

extension LocalTeamOperations on TeamAccess {
  RestTeamOperations toRemote() {
    switch(this) {
      case TeamAccess.ACCEPT_INVITATION: return RestTeamOperations.acceptInvitation;
      case TeamAccess.DENY_INVITATION: return RestTeamOperations.cancelInvitation;
      case TeamAccess.APPLY: return RestTeamOperations.apply;
      case TeamAccess.INVITE: return RestTeamOperations.invite;
      case TeamAccess.JOIN: return RestTeamOperations.join;
      case TeamAccess.LEAVE: return RestTeamOperations.leave;
      case TeamAccess.UNAPPLY: return RestTeamOperations.unapply;
      case TeamAccess.UPDATE: return RestTeamOperations.update;
    }
    return null;
  } 
}

extension RemoteTeam on RestTeam {
  Team toLocal() => Team(
        id: id,
        name: name,
        summary: summary,
        description: description,
        owner: owner?.toLocal(),
//        photoUrls: photoUrls,
//        tags: tags?.map((it) => it.toLocal()),
        visibility: visibility?.toLocal(),
        joinability: joinability?.toLocal(),
        status: status?.toLocal(),
        cans: cans?.map((can) => can.toLocal())?.toSet(),
      );
}

extension RemoteApiError on RestError {
  ApiError toLocal() => ApiError(
        code: code,
        field: field,
        message: message,
        description: description,
        level: level?.toLocal(),
      );
}
