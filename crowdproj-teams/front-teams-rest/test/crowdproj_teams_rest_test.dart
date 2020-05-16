import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crowdproj_teams_rest/rest/TeamsServiceRestHelper.dart';
import 'package:generated_models_teams/model/rest_profile.dart';
import 'package:generated_models_teams/model/rest_profile_status.dart';
import 'package:generated_models_teams/model/rest_response_team.dart';
import 'package:generated_models_teams/model/rest_tag.dart';
import 'package:generated_models_teams/model/rest_team.dart';
import 'package:generated_models_teams/model/rest_team_joinability.dart';
import 'package:generated_models_teams/model/rest_team_operations.dart';
import 'package:generated_models_teams/model/rest_team_status.dart';
import 'package:generated_models_teams/model/rest_team_visibility.dart';

void main() {
  test('adds one to input values', () {
    final remoteApiResponseTeam = RestResponseTeam((upd) => upd
      ..data = ListBuilder<RestTeam>([
        (RestTeamBuilder()
              ..id = "team id"
              ..name = "team name"
              ..summary = "team summary"
              ..description = "team description"
              ..owner = (RestProfileBuilder()
                ..id = "profile id"
                ..alias = "profile alias"
                ..fName = "FirstName"
                ..mName = "MiddleName"
                ..lName = "LastName"
                ..email = "email@profile.dom"
                ..phone = "+9 999 999 9999"
                ..profileStatus = RestProfileStatus.profileActive)
              ..photoUrls = ListBuilder([
                "photo 1",
                "photo 2",
              ])
              ..tags = ListBuilder<RestTag>([
                (RestTagBuilder()
                      ..id = "tag id"
                      ..name = "tag name"
                      ..description = "tag description")
                    .build(),
              ])
              ..status = RestTeamStatus.active
              ..visibility = RestTeamVisibility.teamPublic
              ..joinability = RestTeamJoinability.byUser
              ..cans = ListBuilder([
                RestTeamOperations.acceptInvitation,
                RestTeamOperations.invite,
              ]))
            .build()
      ]));
    final localApiResponseTeam = remoteApiResponseTeam.toLocal();
    final remoteTeamOrig = remoteApiResponseTeam.data.first;
    final remoteTeam2 = localApiResponseTeam.team.toRemote();
    expect(remoteTeam2.id, remoteTeamOrig.id);
    expect(remoteTeam2.name, remoteTeamOrig.name);
    expect(remoteTeam2.summary, remoteTeamOrig.summary);
    expect(remoteTeam2.description, remoteTeamOrig.description);
    expect(remoteTeam2.owner, remoteTeamOrig.owner);
//    expect(remoteTeam2.photoUrls, remoteTeamOrig.photoUrls);
//    expect(remoteTeam2.tags, remoteTeamOrig.tags);
    expect(remoteTeam2.status, remoteTeamOrig.status);
    expect(remoteTeam2.visibility, remoteTeamOrig.visibility);
    expect(remoteTeam2.joinability, remoteTeamOrig.joinability);
    expect(remoteTeam2.cans, remoteTeamOrig.cans);
  });
}
