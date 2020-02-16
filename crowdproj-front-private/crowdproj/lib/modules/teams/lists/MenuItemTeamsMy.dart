import 'package:crowdproj/modules/teams/lists/TeamsMyPage.dart';
import 'package:crowdproj/modules/teams/lists/TeamsPageArgs.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';

class MenuItemTeamsMy extends StatelessWidget {
  MenuItemTeamsMy({Key key, bool enabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(TeamsLocalizations.of(context).titleMyTeams),
      trailing: Icon(Icons.group),
      onTap: () {
        final navigator = Navigator.of(context);
        final arguments = TeamsPageArgs();
        final route = TeamsMyPage.route;
        navigator.pop();
        navigator.push(MaterialPageRoute(
          builder: route.builder,
          settings: RouteSettings(
            name: route.pathFormatted(arguments: arguments),
            arguments: arguments,
          ),
        ));
//        final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
//        navigatorBloc.add(NavigatorActionTeams());
      },
    );
  }
}
