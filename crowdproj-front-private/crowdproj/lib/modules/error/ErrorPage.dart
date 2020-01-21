import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/error/ErrorPathArgs.dart';
import 'package:crowdproj/translations/ErrorLocalizations.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({Key key, this.args}) : super(key: key);

  final ErrorRouteArgs args;

  static String titleFormatter(
          {BuildContext context, RouteSettings settings}) =>
//      HomeLocalizations.of(context).title;
      "Error";

  static String pathFormatter({BuildContext context, RouteSettings settings}) {
    final args = settings.arguments as ErrorRouteArgs;
    return args?.code == null ? "/error" : "/error/${args.code}";
  }

  static final route = RouteDescription(
      id: "ErrorPage",
      pathFormatter: ErrorPage.pathFormatter,
      titleFormatter: ErrorPage.titleFormatter,
      builder: (BuildContext context) {
        return ErrorPage();
      });

  @override
  Widget build(BuildContext context) {
    final localizer = ErrorLocalizations.of(context);
    AppSession.get.routes.setWindow(context);
    final text = "**${localizer.labelFailedPage}**: ${args?.badRoute}\n\n"
        "**${localizer.labelErrorDescription}**: ${_textForCode(localizer,)}";
    return Scaffold(
      appBar: AppBar(
        title: Text(args?.code == null
            ? localizer.titleErrorUncoded
            : localizer.titleErrorCoded(args?.code)),
      ),
      body: Markdown(data: text),
    );
  }

  String _textForCode(ErrorLocalizations localizer) {
    final localArgs = args;
    if (localArgs == null || localArgs.code == null) return localizer.errorWithoutCode(args?.description);
    switch(localArgs.code) {
      case 404: return localizer.error404();
      default: return localizer.unknownError(args?.description);
    }
  }
}
