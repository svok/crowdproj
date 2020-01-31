
import 'package:crowdproj/modules/navigator/NavigatorActionProfile.dart';
import 'package:crowdproj/modules/navigator/NavigatorBloc.dart';
import 'package:flutter/material.dart';
import 'package:crowdproj/translations/AuthLocalizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItemProfile extends PopupMenuItem<String> {
  MenuItemProfile({Key key, bool enabled = true, @required BuildContext context})
      : super(
    key: key,
    value: id,
    enabled: enabled,
//  this.height = kMinInteractiveDimension,
//  this.textStyle,
    child: Text(AuthLocalizations.of(context).titleUpdate),
  );

  static const String id = "profile";
  static callback(BuildContext context) async {
    final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    final event = NavigatorActionProfile(context);
    navigatorBloc.add(event);
  }

}
