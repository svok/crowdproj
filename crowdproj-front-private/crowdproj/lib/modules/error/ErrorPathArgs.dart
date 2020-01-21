import 'package:flutter/material.dart';

class ErrorRouteArgs {
  ErrorRouteArgs({
    this.code,
    this.badRoute,
    this.description,
}): super();

  int code;
  RouteSettings badRoute;
  String description;
}
