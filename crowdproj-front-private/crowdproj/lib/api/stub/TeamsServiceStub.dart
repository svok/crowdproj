import 'package:crowdproj/api/ITeamsService.dart';
import 'package:crowdproj/api/models/TeamJoinability.dart';
import 'package:crowdproj/api/models/TeamStatus.dart';
import 'package:crowdproj/api/models/TeamVisibility.dart';
import 'package:crowdproj/api/models/TeamsQuery.dart';
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
        _generateTeam("1")
      ],
      status: ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }

  Future<ApiResponseTeam> getTeams(TeamsQuery query) async {
    return ApiResponseTeam(
      teams: [
        _generateTeam("1"),
        _generateTeam("2"),
        _generateTeam("3"),
        _generateTeam("4"),
        _generateTeam("5"),
        _generateTeam("6"),
        _generateTeam("7"),
      ],
      status: ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }

  Team _generateTeam(String suf, {String profSuf: "1"}) => Team(
    id: "some-id-$suf",
    name: "Some team $suf",
    summary: "Some team $suf object for testing purposes",
    description: "# Some team $suf\n\nSome team description",
    owner: _generateProfile(profSuf),
    visibility: TeamVisibility.public,
    status: TeamStatus.active,
    joinability: TeamJoinability.byUser,
  );

  Profile _generateProfile(String suf) => Profile(
    id: "some-profile-$suf",
    lName: "Johns-$suf",
    fName: "John-$suf",
    mName: "J",
    email: "john-$suf@johns.com",
    phone: "+1 404 500 500 $suf",
  );

}
