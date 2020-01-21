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

class AuthLocalizations {
  AuthLocalizations(this.localeName);

  static Future<AuthLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AuthLocalizations(localeName);
    });
  }

  static AuthLocalizations of(BuildContext context) =>
      Localizations.of<AuthLocalizations>(context, AuthLocalizations);
  
  static _PromoLocalizationsDelegate _delegate = _PromoLocalizationsDelegate();
  static _PromoLocalizationsDelegate get delegate => _delegate;

  final String localeName;

  String get title => Intl.message(
      'Authentication',
      name: "AuthLocalizations_title",
      desc: 'Default title for AuthPage',
      locale: localeName,
    );

  String get titleLogin => Intl.message(
      'Sign In',
      name: "AuthLocalizations_titleLogin",
      desc: 'Title for Login page',
      locale: localeName,
    );

  String get titleRegister => Intl.message(
      'Sign Up',
      name: "AuthLocalizations_titleRegister",
      desc: 'Title for Registration page',
      locale: localeName,
    );

  String get titleConfirm => Intl.message(
      'Confirm',
      name: "AuthLocalizations_titleConfirm",
      desc: 'Title for email and/or phone number confirmation page',
      locale: localeName,
    );

  String get titleUpdate => Intl.message(
      'Update Account',
      name: "AuthLocalizations_titleUpdate",
      desc: 'Title for user account update page',
      locale: localeName,
    );

  String signoutFor(String userName) => Intl.message(
    'Sign out: $userName',
    name: "AuthLocalizations_signoutFor",
    desc: 'Title for email and/or phone number confirmation page',
    locale: localeName,
    args: [userName],
  );

  String emailError(String faultyEmail) => Intl.message(
    'Email format is invalid: $faultyEmail',
    name: "AuthLocalizations_emailError",
    desc: 'Title for email and/or phone number confirmation page',
    locale: localeName,
    args: [faultyEmail],
  );
}

class _PromoLocalizationsDelegate
    extends LocalizationsDelegate<AuthLocalizations> {
  const _PromoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AuthLocalizations> load(Locale locale) => AuthLocalizations.load(locale);

  @override
  bool shouldReload(_PromoLocalizationsDelegate old) => false;
}

