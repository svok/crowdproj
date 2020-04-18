import 'package:crowdproj/modules/navigator/NavigatorActionDefaultAbstarct.dart';
import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:crowdproj_teams/lists/TeamsPage.dart';
import 'package:flutter/material.dart';

class NavigatorActionLocateTo extends NavigatorActionDefaultAbstract {
  NavigatorActionLocateTo({
    this.context,
    this.route,
    this.pageRoute,
    this.arguments,
  }) : super();

  @override
  final RouteDescription route;
  final BuildContext context;
  final MaterialPageRoute pageRoute;
  final Object arguments;

  @override
  List<Object> get props => [];
}
