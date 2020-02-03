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
  
  final Map<String, Team> teamRepo = {};
  
  TeamsServiceStub(): super() {
    teamRepo.addAll({
      "1": _generateTeam("1"),
      "2": _generateTeam("2"),
      "3": _generateTeam("3"),
      "4": _generateTeam("4"),
      "5": _generateTeam("5"),
      "6": _generateTeam("6"),
      "7": _generateTeam("7"),
      "8": _generateTeam("8"),
      "9": _generateTeam("9"),
      "10": _generateTeam("10"),
      "11": _generateTeam("11"),
      "12": _generateTeam("12"),
      "13": _generateTeam("13"),
      "14": _generateTeam("14"),
      "15": _generateTeam("15"),
      "16": _generateTeam("16"),
      "17": _generateTeam("17"),
      "18": _generateTeam("18"),
      "19": _generateTeam("19"),
      "20": _generateTeam("20"),
      "21": _generateTeam("21"),
      "22": _generateTeam("22"),
      "23": _generateTeam("23"),
      "24": _generateTeam("24"),
      "25": _generateTeam("25"),
      "26": _generateTeam("26"),
      "27": _generateTeam("27"),
      "28": _generateTeam("28"),
      "29": _generateTeam("29"),
      "30": _generateTeam("30"),
      "31": _generateTeam("31"),
      "32": _generateTeam("32"),
      "33": _generateTeam("33"),
      "34": _generateTeam("34"),
      "35": _generateTeam("35"),
      "36": _generateTeam("36"),
      "37": _generateTeam("37"),
      "38": _generateTeam("38"),
      "39": _generateTeam("39"),
      "40": _generateTeam("40"),
      "41": _generateTeam("41"),
      "42": _generateTeam("42"),
      "43": _generateTeam("43"),
      "44": _generateTeam("44"),
      "45": _generateTeam("45"),
      "46": _generateTeam("46"),
      "47": _generateTeam("47"),
      "48": _generateTeam("48"),
      "49": _generateTeam("49"),
      "50": _generateTeam("50"),
      "51": _generateTeam("51"),
      "52": _generateTeam("52"),
      "53": _generateTeam("53"),
      "54": _generateTeam("54"),
      "55": _generateTeam("55"),
      "56": _generateTeam("56"),
      "57": _generateTeam("57"),
      "58": _generateTeam("58"),
      "59": _generateTeam("59"),
      "60": _generateTeam("60"),
      "61": _generateTeam("61"),
      "62": _generateTeam("62"),
      "63": _generateTeam("63"),
      "64": _generateTeam("64"),
      "65": _generateTeam("65"),
      "66": _generateTeam("66"),
      "67": _generateTeam("67"),
      "68": _generateTeam("68"),
      "69": _generateTeam("69"),
      "70": _generateTeam("70"),
      "71": _generateTeam("71"),
      "72": _generateTeam("72"),
      "73": _generateTeam("73"),
      "74": _generateTeam("74"),
      "75": _generateTeam("75"),
      "76": _generateTeam("76"),
      "77": _generateTeam("77"),
      "78": _generateTeam("78"),
      "79": _generateTeam("79"),
      "80": _generateTeam("80"),
      "81": _generateTeam("81"),
      "82": _generateTeam("82"),
      "83": _generateTeam("83"),
      "84": _generateTeam("84"),
      "85": _generateTeam("85"),
      "86": _generateTeam("86"),
      "87": _generateTeam("87"),
      "88": _generateTeam("88"),
      "89": _generateTeam("89"),
    });
  }
  
  Future<ApiResponseTeam> saveTeam(Team team) async {
    final id = Uuid().v4();
    teamRepo[id] = team..id = id;
    return ApiResponseTeam(
      teams: [teamRepo[id]],
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
        teamRepo[teamId],
      ],
      status: ApiResponseStatuses.success,
      errors: [],
      timeRequested: DateTime.now().subtract(Duration(milliseconds: 1000)),
      timeFinished: DateTime.now().subtract(Duration(milliseconds: 800)),
    );
  }

  Future<ApiResponseTeam> getTeams(TeamsQuery query) async {
    return ApiResponseTeam(
      teams: teamRepo.values.toList(),
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
