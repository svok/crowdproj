import 'package:crowdproj/modules/teams/ITeamsService.dart';

import 'models/Team.dart' as local;
import 'models/Profile.dart' as local;
import 'models/ApiResponse.dart' as local;



class TeamsServiceStub implements ITeamsService {

  Future<local.ApiResponseTeamSave> saveTeam(local.Team team) async {
    return local.ApiResponseTeamSave(
      status: local.ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }

  Future<local.ApiResponseTeamGet> getTeam(String teamId) async {
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
