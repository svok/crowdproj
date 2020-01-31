import 'package:crowdproj/modules/navigator/NavigatorActionAbout.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/HomeLocalizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItemAbout extends PopupMenuItem<String> {
  MenuItemAbout({Key key, bool enabled = true, @required BuildContext context})
      : super(
          key: key,
          value: id,
          enabled: enabled,
          child: Text(HomeLocalizations.of(context).titleAbout),
        );
  static const String id = "about";

  static callback(BuildContext context) async {
    final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    final event = NavigatorActionAbout(context);
    navigatorBloc.add(event);
  }
}
