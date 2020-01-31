import 'package:crowdproj/modules/navigator/NavigatorActionTeams.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItemTeams extends PopupMenuItem<String> {
  MenuItemTeams({Key key, bool enabled = true, @required BuildContext context})
      : super(
          key: key,
          value: id,
          enabled: enabled,
          child: Text(TeamsLocalizations.of(context).title),
        );
  static const String id = "teams";

  static callback(BuildContext context) async {
    final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    navigatorBloc.add(NavigatorActionTeams());
  }
}
