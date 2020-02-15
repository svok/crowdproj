import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/error/ErrorPageArgs.dart';
import 'package:crowdproj/translations/ErrorLocalizations.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({Key key, this.args}) : super(key: key);

  final ErrorPageArgs args;

  static final RouteDescription<ErrorPageArgs> route =
      RouteDescription<ErrorPageArgs>(
          id: "ErrorPage",
          pathFormatter: ({ErrorPageArgs arguments}) {
            return arguments?.code == null
                ? "/error"
                : "/error/${arguments.code}";
          },
          titleFormatter: ({BuildContext context, ErrorPageArgs arguments}) =>
              "Error",
          builder: (BuildContext context) {
            return ErrorPage();
          });

  @override
  Widget build(BuildContext context) {
    final localizer = ErrorLocalizations.of(context);
//    AppSession.get.routes.setWindow(context);
    final text = "**${localizer.labelFailedPage}**: ${args?.badRoute}\n\n"
        "**${localizer.labelErrorDescription}**: ${_textForCode(
      localizer,
    )}";
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
    if (localArgs == null || localArgs.code == null)
      return localizer.errorWithoutCode(args?.description);
    switch (localArgs.code) {
      case 404:
        return localizer.error404();
      default:
        return localizer.unknownError(args?.description);
    }
  }
}
