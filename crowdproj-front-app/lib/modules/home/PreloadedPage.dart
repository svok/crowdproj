import 'package:crowdproj/translations/HomeLocalizations.dart';
import 'package:crowdproj_common/widgets/ActivitySpinner.dart';
import 'package:crowdproj_common/widgets/EmptyApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class PreloadedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: Locale("en", "US"),
      delegates: [
        HomeLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: EmptyApp(
        child: ActivitySpinner(
          child: Image.asset(
            "assets/pages-splash-splash.jpeg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
