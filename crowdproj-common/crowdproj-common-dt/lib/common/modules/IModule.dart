import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:flutter/material.dart';

abstract class IModule {
  LocateTo get locateTo;
  List<LocalizationsDelegate> get localizations;
  Iterable<Widget> menuItems();
}

typedef LocateTo = void Function(
  BuildContext context, {
  MaterialPageRoute pageRoute,
  RouteDescription routeDescription,
  dynamic arguments,
});
