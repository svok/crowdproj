
import 'package:flutter/material.dart';

typedef String TitleFormatter<T>({T arguments, @required BuildContext context});
typedef String RouteFormatter<T>({T arguments});

class RouteDescription<T> {
  RouteDescription({
    @required this.id,
    this.pathName,
    this.builder,
    this.pathFormatter,
    this.titleFormatter,
}): super();

  final String id;
  final String pathName;
  final WidgetBuilder builder;
  final RouteFormatter<T> pathFormatter;
  final TitleFormatter<T> titleFormatter;


  String pathFormatted({T arguments}) => pathFormatter != null ? pathFormatter(arguments: arguments) : "";
  String titleFormatted({@required BuildContext context, T arguments}) => titleFormatter != null ? titleFormatter(arguments: arguments, context: context) : "";

  @override
  String toString() => "RouteDescription[id=$id]";
  @override
  bool operator ==(other) {
    return super == other || (other is RouteDescription && other.id == id);
  }
}
