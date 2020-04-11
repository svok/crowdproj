import 'package:crowdproj_teams/TeamPageArguments.dart';
import 'package:crowdproj_teams/crowdproj_teams.dart';
import 'package:crowdproj_teams/view/TeamViewPage.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamsTeamWidget extends StatelessWidget {
  TeamsTeamWidget({
    Key key,
    this.team,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(Icons.group),
    title: Text(team.name),
    subtitle: Text(team.summary),
    trailing: Icon(Icons.arrow_forward_ios),
    onTap: () {
      TeamsModule().locateTo(
          context,
          routeDescription: TeamViewPage.route,
          arguments: TeamPageArguments(
            teamId: team.id,
            team: team,
          ),
      );
//      BlocProvider.of<NavigatorBloc>(context).add(NavigatorActionTeam(
//        teamId: team.id,
//        team: team,
//      ));
    },
  );
}
