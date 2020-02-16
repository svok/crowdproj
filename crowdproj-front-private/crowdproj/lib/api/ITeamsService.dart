import 'package:flutter/material.dart';

import 'models/Team.dart';
import 'models/ApiResponse.dart';
import 'models/TeamsQuery.dart';

abstract class ITeamsService extends ChangeNotifier {
  bool _isUptodate = true;

  bool get isUptodate => _isUptodate;

  void set isUptodate(value) {
    _isUptodate = value;
    notifyListeners();
  }

  Future<ApiResponseTeam> getTeams(TeamsQuery query);

  Future<ApiResponseTeam> saveTeam(Team team);

  Future<ApiResponseTeam> getTeam(String teamId);
}
