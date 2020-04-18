
import 'package:crowdproj/modules/navigator/NavigatorActionProfile.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItemProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(AuthLocalizations.of(context).titleUpdate),
      trailing: Icon(FontAwesomeIcons.userEdit),
      onTap: () {
        Navigator.of(context).pop();
        final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
        navigatorBloc.add(NavigatorActionProfile());
      },
    );
  }

}
