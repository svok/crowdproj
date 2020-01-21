import 'package:flutter/cupertino.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/common/RouteSettingsArgs.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';

class TeamsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsPageState();

  static String titleFormatter({BuildContext context, RouteSettings settings}) =>
      TeamsLocalizations.of(context).title;

  static String pathFormatter({RouteSettings settings}) =>
      "/teams";

  static final route = RouteDescription(
      id: "TeamsPage",
      pathFormatter: TeamsPage.pathFormatter,
      titleFormatter: TeamsPage.titleFormatter,
      builder: (BuildContext context) {
        return TeamsPage();
      });
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return PageSimple(
      title: localizer.title,
      body: Container()
    );
  }
}
