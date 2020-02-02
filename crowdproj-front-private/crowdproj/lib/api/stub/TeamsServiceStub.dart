import 'package:crowdproj/api/ITeamsService.dart';
import 'package:uuid/uuid.dart';

import '../models/Team.dart';
import '../models/Profile.dart';
import '../models/ApiResponse.dart';

class TeamsServiceStub implements ITeamsService {
  Future<ApiResponseTeam> saveTeam(Team team) async {
    return ApiResponseTeam(
      teams: [team..id = Uuid().v4()],
      status: ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }

  Future<ApiResponseTeam> getTeam(String teamId) async {
    print("getTeam: request");
    return ApiResponseTeam(
      teams: [
        Team(
          id: "some-id-1",
          name: "Some team",
          summary: "Some team object for testing purposes",
          description: "# Some team\n\nSome team description",
          owner: Profile(
            id: "some-profile-1",
            lName: "Johns",
            fName: "John",
            mName: "J",
            email: "john@johns.com",
            phone: "+1 404 500 500 404",
          ),
          visibility: TeamVisibility.public,
          status: TeamStatus.active,
          joinability: TeamJoinability.byUser,
        ),
      ],
      status: ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }
}
