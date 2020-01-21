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

class ErrorLocalizations {
  ErrorLocalizations(this.localeName);

  static Future<ErrorLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return ErrorLocalizations(localeName);
    });
  }

  static ErrorLocalizations of(BuildContext context) =>
      Localizations.of<ErrorLocalizations>(context, ErrorLocalizations);

  static _ErrorLocalizationsDelegate _delegate = _ErrorLocalizationsDelegate();

  static _ErrorLocalizationsDelegate get delegate => _delegate;

  final String localeName;

  String titleErrorCoded(int code) => Intl.message(
        'Error: $code',
        name: "ErrorLocalizations_titleErrorCoded",
        desc: 'Title error page with error code',
        locale: localeName,
        args: [code],
      );

  String get titleErrorUncoded => Intl.message(
        'Error',
        name: "ErrorLocalizations_titleErrorUncoded",
        desc: 'Title error page without error code',
        locale: localeName,
        args: [],
      );

  String get labelFailedPage => Intl.message(
        'Failed page',
        name: "ErrorLocalizations_labelFailedPage",
        desc: 'Label for failed page field on Error page',
        locale: localeName,
        args: [],
      );

  String get labelErrorDescription => Intl.message(
        'Error description',
        name: "ErrorLocalizations_labelErrorDescription",
        desc: 'Label for error description field on Error page',
        locale: localeName,
        args: [],
      );

  String errorWithoutCode(String description) => Intl.message(
    'Sorry. An error has occured. The error description: $description',
    name: "ErrorLocalizations_errorWithoutCode",
    desc: 'Description for an error having no code',
    locale: localeName,
    args: [description],
  );

  String error404() => Intl.message(
    'Sorry. The page you are loogin for is not found here',
    name: "ErrorLocalizations_error404",
    desc: 'Description for error 404',
    locale: localeName,
    args: [],
  );

  String unknownError(String description) => Intl.message(
    'Sorry. Unknown error has occured. The error description: $description',
    name: "ErrorLocalizations_unknownError",
    desc: 'Description for unknown error',
    locale: localeName,
    args: [description],
  );
}

class _ErrorLocalizationsDelegate
    extends LocalizationsDelegate<ErrorLocalizations> {
  const _ErrorLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<ErrorLocalizations> load(Locale locale) =>
      ErrorLocalizations.load(locale);

  @override
  bool shouldReload(_ErrorLocalizationsDelegate old) => false;
}
