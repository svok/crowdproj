import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:crowdproj/widgets/ActivitySpinner.dart';

import 'common/AppSession.dart';
import 'modules/home/HomePage.dart';
import 'translations/AuthLocalizations.dart';
import 'translations/ErrorLocalizations.dart';
import 'translations/HomeLocalizations.dart';
import 'translations/PromoLocalizations.dart';
import 'translations/TeamsLocalizations.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: AppSession.init(context).then((value) {
          return true;
        }),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot?.data == true
              ? buildFutured(context)
              : ActivitySpinner();
        },
      );

  Widget buildFutured(BuildContext context) {
    return MaterialApp(
//      locale: Locale('ru', 'RU'),
      localizationsDelegates: [
        TeamsLocalizations.delegate,
        AuthLocalizations.delegate,
        HomeLocalizations.delegate,
        PromoLocalizations.delegate,
        ErrorLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('ru', 'RU'), // Russian
      ],
      localeResolutionCallback: (Locale locale, Iterable supportedLocales) {
        final currLocale = locale ?? AppSession.get.locale ?? window.locale;

        print(
            " detecting locale for: $locale, ${AppSession.get.locale}, ${window.locale}");
        print(" phone languageCode........${currLocale?.languageCode}");
        print(" phone countryCode........${currLocale?.countryCode}");
//        Map<String, String> env = Platform.environment;
//        env.forEach((key, val) {
//          print(" ENV $key = $val");
//        });

        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == currLocale?.languageCode ||
              supportedLocale.countryCode == currLocale?.countryCode) {
            debugPrint("*language ok $supportedLocale");
            return supportedLocale;
          }
        }

        debugPrint("*language to fallback ${supportedLocales.first}");
        return supportedLocales.first;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppSession.get.routes.routeTo,
      home: HomePage(),
    );
  }
}
