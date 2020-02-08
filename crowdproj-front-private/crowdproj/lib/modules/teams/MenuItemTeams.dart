import 'package:crowdproj/modules/navigator/NavigatorActionTeams.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItemTeams extends StatelessWidget {
  MenuItemTeams({Key key, bool enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(TeamsLocalizations.of(context).title),
      trailing: Icon(Icons.group),
      onTap: () {
        Navigator.of(context).pop();
        final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
        navigatorBloc.add(NavigatorActionTeams());
      },
    );
  }
}
