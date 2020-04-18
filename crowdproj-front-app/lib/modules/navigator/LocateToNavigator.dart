import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'NavigatorActionLocateTo.dart';
import 'NavigatorBloc.dart';

class LocateToNavigator {
  static void locateTo(
      BuildContext context, {
        MaterialPageRoute pageRoute,
        RouteDescription routeDescription,
        dynamic arguments,
      }) {
    final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    navigatorBloc.add(NavigatorActionLocateTo(
      context: context,
      route: routeDescription,
      arguments: arguments,
    ));

  }
}