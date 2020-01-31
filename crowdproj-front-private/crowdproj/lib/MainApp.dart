import 'dart:ui';

import 'package:crowdproj/modules/navigator/NavigatorAction.dart';
import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsEvent.dart';
import 'package:crowdproj/modules/teams/TeamsService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:crowdproj/widgets/ActivitySpinner.dart';

import 'common/AppSession.dart';
import 'modules/home/HomePage.dart';
import 'modules/navigator/NavigatorBloc.dart';
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
    final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
    print("STARTING MainApp");
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigatorBloc>(
          create: (context) {
            print("CREATING NavigatorBloc");
            return NavigatorBloc();
          },
        ),
        BlocProvider<TeamsBloc>(
          create: (context) {
            print("CREATING TeamsBloc");
            return TeamsBloc(
              service: TeamsService(),
            )
              ..add(TeamsEventEditRequested());
          },
        ),
      ],
      child: MaterialApp(
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

            for (Locale supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == currLocale?.languageCode ||
                  supportedLocale.countryCode == currLocale?.countryCode) {
                return supportedLocale;
              }
            }

            return supportedLocales.first;
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
//          onGenerateRoute: AppSession.get.routes.routeTo,
          home: HomePage()
      ),
    );
  }
}
