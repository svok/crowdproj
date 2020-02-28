import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/modules/layouts/PageSimple.dart';

import 'package:crowdproj/translations/HomeLocalizations.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();

  static final RouteDescription route = RouteDescription(
      id: "AboutPage",
      pathFormatter: ({Object arguments}) => "/about",
      titleFormatter: ({BuildContext context, Object arguments}) =>
          HomeLocalizations.of(context).titleAbout,
      builder: (BuildContext context) {
        return AboutPage();
      });
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final localizer = HomeLocalizations.of(context);
    return PageSimple(
      title: localizer.titleAbout,
      body: FutureBuilder(
        builder: buildWidget,
        future: _getMd(),
      ),
    );
  }

  Widget buildWidget(BuildContext context, AsyncSnapshot<String> snapshot) =>
      snapshot?.data != null
          ? Markdown(
              data: snapshot.data,
              selectable: true,
//              imageDirectory: 'resource:assets/pages/about',
              onTapLink: (String href) async {
                print("LINK: ${href}");
              },
            )
          : Container();

  Future<String> _getMd() async =>
      await rootBundle.loadString('assets/pages-about-about.txt');
}
