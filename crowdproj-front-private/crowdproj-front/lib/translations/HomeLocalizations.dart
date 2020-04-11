import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// This file was generated in two steps, using the Dart intl tools. With the
// app's root directory (the one that contains pubspec.yaml) as the current
// directory:
//
// flutter pub get
// flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/main.dart
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/main.dart lib/l10n/intl_*.arb
//
// The second command generates intl_messages.arb and the third generates
// messages_all.dart. There's more about this process in
// https://pub.dev/packages/intl.
import '../l10n/messages_all.dart';

class HomeLocalizations {
  HomeLocalizations(this.localeName);

  static Future<HomeLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return HomeLocalizations(localeName);
    });
  }

  static HomeLocalizations of(BuildContext context) =>
      Localizations.of<HomeLocalizations>(context, HomeLocalizations);

  static _HomeLocalizationsDelegate _delegate = _HomeLocalizationsDelegate();

  static _HomeLocalizationsDelegate get delegate => _delegate;

  final String localeName;

  String get title => Intl.message(
        'Hello World',
        name: "HomeLocalizations_title",
        desc: 'Title for the Demo application',
        locale: localeName,
      );

  String get titleAbout => Intl.message(
        'About',
        name: "HomeLocalizations_titleAbout",
        desc: 'Title for the about page',
        locale: localeName,
      );

  String get loading => Intl.message(
    'Loading...',
    name: "HomeLocalizations_loading",
    desc: 'Label for loading spinner',
    locale: localeName,
  );

}

class _HomeLocalizationsDelegate
    extends LocalizationsDelegate<HomeLocalizations> {
  const _HomeLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<HomeLocalizations> load(Locale locale) =>
      HomeLocalizations.load(locale);

  @override
  bool shouldReload(_HomeLocalizationsDelegate old) => false;
}
