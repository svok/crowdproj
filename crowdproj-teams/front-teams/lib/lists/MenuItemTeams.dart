import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TeamsModule.dart';
import 'TeamsPage.dart';

class MenuItemTeams extends StatelessWidget {
  MenuItemTeams({Key key, bool enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(TeamsLocalizations.of(context).titleTeams),
      trailing: Icon(Icons.group),
      onTap: () {
        Navigator.of(context).pop();
        TeamsModule().locateTo(context, routeDescription: TeamsPage.route);
//        final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
//        navigatorBloc.add(NavigatorActionTeams());
      },
    );
  }
}
