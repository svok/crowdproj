import 'package:crowdproj/api/ITeamsService.dart';
import 'package:crowdproj/api/models/TeamAccess.dart';
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
    if (validationResult != null) return validationResult;
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
          TeamRelations.invitations,
          TeamRelations.applied,
        ];
        break;
      case TeamRelations.accessed:
        relations = [
          TeamRelations.own,
          TeamRelations.member,
          TeamRelations.accessed,
          TeamRelations.invitations,
          TeamRelations.applied,
        ];
        break;
      case TeamRelations.invitations:
        relations = [
          TeamRelations.invitations,
          TeamRelations.applied,
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

  Team _generateTeam(String suf, {String profSuf: "1"}) {
    switch(suf) {
      case "1": return _generateTeamOwn(suf);
      case "2": return _generateTeamMember(suf);
      case "3": return _generateTeamApplied(suf);
      case "4": return _generateTeamInvitation(suf);
      case "5": return _generateTeamGeneral(suf);
      default: return _generateTeamDefault(suf);
    }
  }

  Team _generateTeamOwn(String suf, {String profSuf: "1"}) => Team(
        id: "some-id-$suf",
        name: "Some team $suf owner",
        summary: "Some team $suf object for testing purposes",
        description: "# Some team $suf\n\nSome team description",
        owner: _generateProfile(profSuf),
        visibility: TeamVisibility.public,
        status: TeamStatus.active,
        joinability: TeamJoinability.byMember,
        relation: TeamRelations.own,
        cans: [TeamAccess.UPDATE, TeamAccess.INVITE],
      );

  Team _generateTeamMember(String suf, {String profSuf: "2"}) => Team(
        id: "some-id-$suf",
        name: "Some team $suf member",
        summary: "Some team $suf object for testing purposes",
        description: "# Some team $suf\n\nSome team description",
        owner: _generateProfile(profSuf),
        visibility: TeamVisibility.public,
        status: TeamStatus.active,
        joinability: TeamJoinability.byMember,
        relation: TeamRelations.member,
        cans: [TeamAccess.LEAVE, TeamAccess.INVITE],
      );

  Team _generateTeamApplied(String suf, {String profSuf: "3"}) => Team(
        id: "some-id-$suf",
        name: "Some team $suf applied",
        summary: "Some team $suf object for testing purposes",
        description: "# Some team $suf\n\nSome team description",
        owner: _generateProfile(profSuf),
        visibility: TeamVisibility.public,
        status: TeamStatus.active,
        joinability: TeamJoinability.byMember,
        relation: TeamRelations.applied,
        cans: [TeamAccess.UNAPPLY],
      );

  Team _generateTeamInvitation(String suf, {String profSuf: "4"}) => Team(
        id: "some-id-$suf",
        name: "Some team $suf invitation",
        summary: "Some team $suf object for testing purposes",
        description: "# Some team $suf\n\nSome team description",
        owner: _generateProfile(profSuf),
        visibility: TeamVisibility.public,
        status: TeamStatus.active,
        joinability: TeamJoinability.byMember,
        relation: TeamRelations.invitations,
        cans: [TeamAccess.DENY_INVITATION, TeamAccess.DENY_INVITATION],
      );

  Team _generateTeamGeneral(String suf, {String profSuf: "5"}) => Team(
        id: "some-id-$suf",
        name: "Some team $suf general",
        summary: "Some team $suf object for testing purposes",
        description: "# Some team $suf\n\nSome team description",
        owner: _generateProfile(profSuf),
        visibility: TeamVisibility.public,
        status: TeamStatus.active,
        joinability: TeamJoinability.byMember,
        relation: TeamRelations.accessed,
        cans: [TeamAccess.APPLY],
      );

  Team _generateTeamDefault(String suf, {String profSuf: "6"}) => Team(
        id: "some-id-$suf",
        name: "Some team $suf default",
        summary: "Some team $suf object for testing purposes",
        description: "# Some team $suf\n\nSome team description",
        owner: _generateProfile(profSuf),
        visibility: TeamVisibility.public,
        status: TeamStatus.active,
        joinability: TeamJoinability.byUser,
        relation: TeamRelations.accessed,
        cans: [TeamAccess.JOIN],
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

  @override
  Future<ApiResponseTeam> applyMembership(String teamId) => _makeOperation(teamId, (team) {
    team
      ..cans = [
        "unapply",
      ]
      ..relation = TeamRelations.member;
  });


  @override
  Future<ApiResponseTeam> joinMembership(String teamId) => _makeOperation(teamId, (team) {
    team
      ..cans = [
        if (team.joinability == TeamJoinability.byMember) "invite",
        "leave",
      ]
      ..relation = TeamRelations.member;
  });

  @override
  Future<ApiResponseTeam> acceptInvitation(String teamId) => _makeOperation(teamId, (team) {
    team
      ..cans = [
        if (team.joinability == TeamJoinability.byMember) "invite",
        "leave",
      ]
      ..relation = TeamRelations.member;
  });

  @override
  Future<ApiResponseTeam> denyInvitation(String teamId) => _makeOperation(teamId, (team) {
    team
      ..cans = [
        if (team.joinability == TeamJoinability.byUser) "join" else "apply"
      ]
      ..relation = ([TeamVisibility.public, TeamVisibility.registeredOnly]
          .contains(team.visibility)
          ? TeamRelations.accessed
          : TeamRelations.unavailable);
  });

  @override
  Future<ApiResponseTeam> invite(String teamId, String profileId) => _makeOperation(teamId, (team) {

  });

  @override
  Future<ApiResponseTeam> leaveTeam(String teamId) =>
      _makeOperation(teamId, (team) {
        team
          ..cans = [
            if (team.joinability == TeamJoinability.byUser) "join" else "apply"
          ]
          ..relation = ([TeamVisibility.public, TeamVisibility.registeredOnly]
                  .contains(team.visibility)
              ? TeamRelations.accessed
              : TeamRelations.unavailable);
      });

  Future<ApiResponseTeam> _makeOperation(
      String teamId, TeamOperation teamOperation) async {
    await Future.delayed(Duration(milliseconds: 500));
    final validationResult = _validateRequest(teamId);
    if (validationResult != null) return validationResult;
    final team = teamRepo[teamId];
    teamOperation(team);

    return ApiResponseTeam(
      teams: [team],
      status: ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }

  @override
  Future<ApiResponseTeam> unapplyMembership(String teamId) => _makeOperation(teamId, (team) {
    team
      ..cans = [
        if (team.joinability == TeamJoinability.byUser) "join" else "apply"
      ]
      ..relation = ([TeamVisibility.public, TeamVisibility.registeredOnly]
          .contains(team.visibility)
          ? TeamRelations.accessed
          : TeamRelations.unavailable);
  });

}

typedef void TeamOperation(Team team);
