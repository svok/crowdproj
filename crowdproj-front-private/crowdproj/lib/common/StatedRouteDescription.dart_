
import 'package:flutter/material.dart';

import 'RouteDescription.dart';

typedef String TitleFormatter({RouteSettings settings, @required BuildContext context});
typedef String RouteFormatter({RouteSettings settings});

class StatedRouteDescription {
  StatedRouteDescription({
  this.route,
    this.settings
}): super();

  RouteDescription route;
  RouteSettings settings;

  String path() => route.pathFormatted(settings: settings);
  String title({@required BuildContext context}) => route.titleFormatter(context: context, settings: settings);

  @override
  String toString() {
    return "StatedRouteDescription[route: ${route.toString()} settings: $settings]";
  }

  @override
  bool operator ==(other) {
    return super == other || (other is StatedRouteDescription && other.route == route && other.settings == settings);
  }
}
