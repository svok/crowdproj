import 'package:crowdproj_common/common/RouteDescription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
    final arguments = ModalRoute.of(context)?.settings?.arguments;
    final args = this.args ?? (arguments is ErrorPageArgs ? arguments : null);
//    AppSession.get.routes.setWindow(context);
    final text = "**${localizer.labelFailedPage}**: ${args?.badRoute?.name}\n\n"
        "**${localizer.labelErrorDescription}**: ${_textForCode(localizer, args)}";
    return Scaffold(
      appBar: AppBar(
        title: Text(args?.code == null
            ? localizer.titleErrorUncoded
            : localizer.titleErrorCoded(args?.code)),
      ),
      body: Markdown(data: text),
    );
  }

  String _textForCode(ErrorLocalizations localizer, ErrorPageArgs args) {
    if (args.description != null) return args.description;
    if (args == null || args.code == null)
      return localizer.errorWithoutCode(args?.description);
    switch (args.code) {
      case 403:
        return localizer.error403();
      case 404:
        return localizer.error404();
      default:
        return localizer.unknownError(args?.description);
    }
  }
}
