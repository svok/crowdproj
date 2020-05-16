import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:generated_models_teams/model/api_response_team.dart' as remote;
import 'package:generated_models_teams/model/profile.dart' as remote;
import 'package:generated_models_teams/model/profile_status.dart' as remote;
import 'package:generated_models_teams/model/tag.dart' as remote;
import 'package:generated_models_teams/model/team_joinability.dart' as remote;
import 'package:generated_models_teams/model/team.dart' as remote;
import 'package:generated_models_teams/model/team_status.dart' as remote;
import 'package:generated_models_teams/model/team_visibility.dart' as remote;

import 'package:crowdproj_teams_rest/rest/TeamsServiceRestHelper.dart';

void main() {
  test('adds one to input values', () {
    final remoteApiResponseTeam = remote.ApiResponseTeam((upd) => upd
      ..data = ListBuilder<remote.Team>([
        (remote.TeamBuilder()
              ..id = "team id"
              ..name = "team name"
              ..summary = "team summary"
              ..description = "team description"
              ..owner = (remote.ProfileBuilder()
                ..id = "profile id"
                ..alias = "profile alias"
                ..fName = "FirstName"
                ..mName = "MiddleName"
                ..lName = "LastName"
                ..email = "email@profile.dom"
                ..phone = "+9 999 999 9999"
                ..profileStatus = remote.ProfileStatus.profileActive)
              ..photoUrls = ListBuilder([
                "photo 1",
                "photo 2",
              ])
              ..tags = ListBuilder<remote.Tag>([
                (remote.TagBuilder()
                      ..id = "tag id"
                      ..name = "tag name"
                      ..description = "tag description")
                    .build(),
              ])
              ..status = remote.TeamStatus.active
              ..visibility = remote.TeamVisibility.teamPublic
              ..joinability = remote.TeamJoinability.byUser
              ..cans = ListBuilder([
                "can 1",
                "can 2",
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
