
import 'package:flutter/material.dart';

typedef String TitleFormatter({RouteSettings settings, @required BuildContext context});
typedef String RouteFormatter({RouteSettings settings});

class RouteDescription {
  RouteDescription({
    @required this.id,
    this.pathName,
    this.builder,
    this.pathFormatter,
    this.titleFormatter,
}): super();

  String id;
  String pathName;
  WidgetBuilder builder;
  RouteFormatter pathFormatter;
  TitleFormatter titleFormatter;


  String pathFormatted({RouteSettings settings}) => pathFormatter != null ? pathFormatter(settings: settings) : "";
  String titleFormatted({@required BuildContext context, RouteSettings settings}) => titleFormatter != null ? titleFormatter(settings: settings, context: context) : "";

  @override
  String toString() => "RouteDescription[id=$id]";
  @override
  bool operator ==(other) {
    return super == other || (other is RouteDescription && other.id == id);
  }
}
