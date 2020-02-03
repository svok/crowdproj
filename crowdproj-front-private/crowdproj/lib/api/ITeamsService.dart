import 'models/Team.dart';
import 'models/ApiResponse.dart';
import 'models/TeamsQuery.dart';

abstract class ITeamsService {
  Future<ApiResponseTeam> getTeams(TeamsQuery query);

  Future<ApiResponseTeam> saveTeam(Team team);

  Future<ApiResponseTeam> getTeam(String teamId);
}
