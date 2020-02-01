import 'dart:ui';

import 'package:crowdproj/modules/home/PreloadedPage.dart';
import 'package:crowdproj/modules/navigator/NavigatorActionPromo.dart';
import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsEvent.dart';
import 'package:crowdproj/modules/teams/TeamsService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'common/AppSession.dart';
import 'modules/auth/AuthService.dart';
import 'modules/navigator/NavigatorBloc.dart';
import 'translations/AuthLocalizations.dart';
import 'translations/ErrorLocalizations.dart';
import 'translations/HomeLocalizations.dart';
import 'translations/PromoLocalizations.dart';
import 'translations/TeamsLocalizations.dart';

class MainApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: AppSession.init(context).then((value) {
          return true;
        }),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot?.data == true
              ? buildFutured(context)
              : PreloadedPage();
        },
      );

  Widget buildFutured(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
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
      home: MultiProvider(
        providers: [
          BlocProvider<NavigatorBloc>(
            create: (context) {
              print("CREATING NavigatorBloc");
              return NavigatorBloc(navigatorKey: _navigatorKey);
            },
          ),
          BlocProvider<TeamsBloc>(
            create: (context) {
              print("CREATING TeamsBloc");
              return TeamsBloc(service: TeamsService());
            },
          ),
          ChangeNotifierProvider<AuthService>(
            create: (context) {
              print("CREATING AuthService");
              return AppSession.get.authService;
            },
          ),
        ],
        child: Consumer<AuthService>(builder: (context, value, child) {
          final teamsBloc = BlocProvider.of<TeamsBloc>(context);
          print("TEAMS STATE: ${teamsBloc?.state}");
          final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
          print("CONSUMER - CHILD: ${child?.runtimeType} VALUE: ${value?.runtimeType}");
          final home = AppSession.get.resolveHome();
          print("DROWING HOME: ${home.runtimeType}");
          return home;
        }),
      ),
    );
  }
}
