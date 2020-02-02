import 'dart:ui';

import 'package:crowdproj/modules/home/PreloadedPage.dart';
import 'package:crowdproj/modules/teams/TeamsBloc.dart';
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
    return MultiProvider(
      providers: [
        BlocProvider<NavigatorBloc>(
          create: (context) => NavigatorBloc(navigatorKey: _navigatorKey),
        ),
        BlocProvider<TeamsBloc>(
          create: (context) => TeamsBloc(navigatorKey: _navigatorKey),
        ),
        ChangeNotifierProvider.value(value: AppSession.get.authService),
      ],
      child: MaterialApp(
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
        home: Consumer<AuthService>(builder: (context, value, child) {
          final teamsBloc = BlocProvider.of<TeamsBloc>(context);
          final navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
          final home = AppSession.get.resolveHome();
          return home;
        }),
      ),
    );
  }
}
