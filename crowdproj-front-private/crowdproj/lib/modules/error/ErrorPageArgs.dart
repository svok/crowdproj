import 'package:flutter/material.dart';

class ErrorPageArgs {
  ErrorPageArgs({
    this.code,
    this.badRoute,
    this.description,
}): super();

  int code;
  RouteSettings badRoute;
  String description;
}
