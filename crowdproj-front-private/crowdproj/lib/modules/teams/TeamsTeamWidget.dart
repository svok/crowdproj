import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionTeam.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
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
    onTap: () {
      BlocProvider.of<NavigatorBloc>(context).add(NavigatorActionTeam(
        teamId: team.id,
        team: team,
      ));
    },
  );
}
