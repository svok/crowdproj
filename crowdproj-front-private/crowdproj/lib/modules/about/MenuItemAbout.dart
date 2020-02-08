import 'package:crowdproj/modules/navigator/NavigatorActionAbout.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/HomeLocalizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItemAbout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(HomeLocalizations.of(context).titleAbout),
      trailing: Icon(FontAwesomeIcons.info),
      onTap: () {
        Navigator.of(context).pop();
        final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
        navigatorBloc.add(NavigatorActionAbout());
      },
    );
  }
}
