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

class PromoLocalizations {
  PromoLocalizations(this.localeName);

  static Future<PromoLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return PromoLocalizations(localeName);
    });
  }

  static PromoLocalizations of(BuildContext context) =>  
      Localizations.of<PromoLocalizations>(context, PromoLocalizations);
  
  static _PromoLocalizationsDelegate _delegate = _PromoLocalizationsDelegate();
  static _PromoLocalizationsDelegate get delegate => _delegate;

  final String localeName;

  String get title => Intl.message(
      'Promo World',
      name: "PromoLocalizations_title",
      desc: 'Title for the Demo application',
      locale: localeName,
    );
}

class _PromoLocalizationsDelegate
    extends LocalizationsDelegate<PromoLocalizations> {
  const _PromoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<PromoLocalizations> load(Locale locale) => PromoLocalizations.load(locale);

  @override
  bool shouldReload(_PromoLocalizationsDelegate old) => false;
}

