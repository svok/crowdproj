import 'package:crowdproj/api/ITeamsService.dart';
import 'package:crowdproj/api/models/TeamJoinability.dart';
import 'package:crowdproj/api/models/TeamRelations.dart';
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
    Iterable<int>.generate(100)
        .map((it) => _generateTeam(it.toString()))
        .forEach((it) {
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
    await Future.delayed(Duration(milliseconds: 500));
    if (team.id == null) {
      team
        ..id = Uuid().v4()
        ..relation = TeamRelations.own
        ..cans = ["update"];
    } else {
      final oldTeam = teamRepo[team.id];
      final validationResult = _validateRequest(team.id);
      if (validationResult != null) return validationResult;
      team.relation = oldTeam.relation;
    }
    teamRepo[team.id] = team;
    final result = ApiResponseTeam(
      teams: [team],
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
    await Future.delayed(Duration(milliseconds: 500));
    final validationResult = _validateRequest(teamId);
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
    List<TeamRelations> relations;
    switch (query.relation) {
      case TeamRelations.own:
        relations = [
          TeamRelations.own,
        ];
        break;
      case TeamRelations.member:
        relations = [
          TeamRelations.own,
          TeamRelations.member,
        ];
        break;
      case TeamRelations.accessed:
        relations = [
          TeamRelations.own,
          TeamRelations.member,
          TeamRelations.accessed,
        ];
        break;
      default:
        relations = [];
        break;
    }

    return ApiResponseTeam(
      teams: teamRepo.values
          .where((element) => relations.contains(element.relation))
          .skip(offset)
          .take(limit)
          .toList(),
      status: ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }

  @override
  Future<ApiResponseTeam> applyMembership(String teamId) =>
      joinMembership(teamId);

  @override
  Future<ApiResponseTeam> joinMembership(String teamId) async {
    await Future.delayed(Duration(milliseconds: 500));
    final validationResult = _validateRequest(teamId);
    if (validationResult != null) return validationResult;
    final team = teamRepo[teamId];
    switch (team.relation) {
      case TeamRelations.own:
        return ApiResponseTeam(
          status: ApiResponseStatuses.error,
          errors: [
            ApiError(
              code: "not-required",
              message: "Not required joining own team",
              description:
                  "You are trying to join your own team. It is not required since you have complete control over that.",
              level: ErrorLevels.error,
            ),
          ],
          timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
          timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
        );
      case TeamRelations.member:
        return ApiResponseTeam(
          status: ApiResponseStatuses.error,
          errors: [
            ApiError(
              code: "not-required",
              message: "Not required joining membered team",
              description:
                  "You are trying to join a team that you have been bein a member of.",
              level: ErrorLevels.error,
            ),
          ],
          timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
          timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
        );
      case TeamRelations.accessed:
      case TeamRelations.invitations:
        break;
      case TeamRelations.unavailable:
        return ApiResponseTeam(
          status: ApiResponseStatuses.error,
          errors: [
            ApiError(
              code: "access-restricted",
              message: "Not allowed",
              description:
                  "You are not allowed to apply for the membership to this team.",
              level: ErrorLevels.error,
            ),
          ],
          timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
          timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
        );
    }
    team
      ..relation = TeamRelations.member
      ..cans.remove("join")
      ..cans.remove("append")
      ..cans.add("leave");

    return ApiResponseTeam(
      teams: [team],
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
        joinability: profSuf.endsWith("2")
            ? TeamJoinability.byUser
            : TeamJoinability.byMember,
        relation: (["13", "17", "19"].contains(suf)
            ? TeamRelations.member
            : (["21", "9"].contains(suf)
                ? TeamRelations.invitations
                : TeamRelations.accessed)),
        cans: [
          if (["2"].contains(suf)) ...["join", ] else "apply",
          if (["1"].contains(suf)) ...["update", ""],
          if (suf.endsWith("1")) "update",
          if (["13", "17", "19"].contains(suf)) "leave",
        ],
      );

  Team _generateTeamOwn(String suf, {String profSuf: "1"}) => Team(
        id: "some-id-$suf",
        name: "Some team $suf",
        summary: "Some team $suf object for testing purposes",
        description: "# Some team $suf\n\nSome team description",
        owner: _generateProfile(profSuf),
        visibility: TeamVisibility.public,
        status: TeamStatus.active,
        joinability: TeamJoinability.byMember,
        relation: TeamRelations.own,
        cans: ["update"],
      );

  Team _generateTeamMember(String suf, {String profSuf: "1"}) => Team(
        id: "some-id-$suf",
        name: "Some team $suf",
        summary: "Some team $suf object for testing purposes",
        description: "# Some team $suf\n\nSome team description",
        owner: _generateProfile(profSuf),
        visibility: TeamVisibility.public,
        status: TeamStatus.active,
        joinability: TeamJoinability.byMember,
        relation: TeamRelations.member,
        cans: ["leave", "update"],
      );

  Team _generateTeamInvitation(String suf, {String profSuf: "1"}) => Team(
        id: "some-id-$suf",
        name: "Some team $suf",
        summary: "Some team $suf object for testing purposes",
        description: "# Some team $suf\n\nSome team description",
        owner: _generateProfile(profSuf),
        visibility: TeamVisibility.public,
        status: TeamStatus.active,
        joinability: TeamJoinability.byMember,
        relation: TeamRelations.invitations,
        cans: ["unapply", "accept"],
      );

  Profile _generateProfile(String suf) => Profile(
        id: "some-profile-$suf",
        lName: "Johns-$suf",
        fName: "John-$suf",
        mName: "J",
        email: "john-$suf@johns.com",
        phone: "+1 404 500 500 $suf",
      );

  ApiResponseTeam _validateRequest(String teamId) {
    if (teamRepo[teamId] != null) return null;
    return ApiResponseTeam(
      status: ApiResponseStatuses.error,
      errors: [
        ApiError(
          code: "not-found",
          message: "No such team",
          description:
              "The team you are requesting does not exitst or not available",
          level: ErrorLevels.error,
        ),
      ],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }
}
