import 'package:crowdproj/api/ITeamsService.dart';
import 'package:crowdproj/api/models/TeamJoinability.dart';
import 'package:crowdproj/api/models/TeamStatus.dart';
import 'package:crowdproj/api/models/TeamVisibility.dart';
import 'package:crowdproj/api/models/TeamsQuery.dart';
import 'package:uuid/uuid.dart';

import '../models/Team.dart';
import '../models/Profile.dart';
import '../models/ApiResponse.dart';

class TeamsServiceStub extends ITeamsService {
  final Map<String, Team> teamRepo = {};

  TeamsServiceStub() : super() {
    Iterable<int>.generate(100).map((it) => _generateTeam(it.toString())).forEach((it) {
      teamRepo[it.id] = it;
    });
  }

  Future<ApiResponseTeam> saveTeam(Team team) async {
    if (team == null)
      return ApiResponseTeam(
        status: ApiResponseStatuses.error,
        errors: [
          ApiError(
            code: "nothing-to-save",
            message: "Request does not contain object to save",
            description:
                "The object was not provided to the request that implies saving the object. So, the operation is not possible",
            level: ErrorLevels.error,
          )
        ],
      );
    if (team?.id != null && teamRepo[team.id] == null) {
      return ApiResponseTeam(
        status: ApiResponseStatuses.error,
        errors: [
          ApiError(
            code: "not-found",
            message: "Object your are saving doesn't exist",
            description:
            "You are trying to save an object that doesn't exist in the database",
            level: ErrorLevels.error,
          )
        ],
      );
    }
    await Future.delayed(Duration(milliseconds: 500));
    final id = team?.id ?? Uuid().v4();
    teamRepo[id] = team..id = id;
    final result = ApiResponseTeam(
      teams: [teamRepo[id]],
      status: ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
    notifyListeners();
    isUptodate = false;
    return result;
  }

  Future<ApiResponseTeam> getTeam(String teamId) async {
    print("getTeam: request");
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponseTeam(
      teams: [
        teamRepo[teamId],
      ],
      status: ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }

  Future<ApiResponseTeam> getTeams(TeamsQuery query) async {
    final offset = query?.offset ?? 0;
    final limit = query?.limit ?? 20;
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponseTeam(
      teams: teamRepo.values.skip(offset).take(limit).toList(),
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
