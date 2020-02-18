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

class TeamsLocalizations {
  TeamsLocalizations(this.localeName);

  static Future<TeamsLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return TeamsLocalizations(localeName);
    });
  }

  static TeamsLocalizations of(BuildContext context) =>
      Localizations.of<TeamsLocalizations>(context, TeamsLocalizations);

  static _TeamsLocalizationsDelegate _delegate = _TeamsLocalizationsDelegate();

  static _TeamsLocalizationsDelegate get delegate => _delegate;

  final String localeName;

  String get titleTeams => Intl.message(
        'Teams',
        name: "TeamsLocalizations_title",
        desc: 'Title for the Teams list page',
        locale: localeName,
      );

  String get titleMyTeams => Intl.message(
        'My Teams',
        name: "TeamsLocalizations_titleMyTeams",
        desc: 'Title for the My Teams page',
        locale: localeName,
      );

  String get titleCreate => Intl.message(
        'Create Team',
        name: "TeamsLocalizations_titleCreate",
        desc: 'Title for the team creation',
        locale: localeName,
      );

  String get titleUpdate => Intl.message(
        'Update Team',
        name: "TeamsLocalizations_titleUpdate",
        desc: 'Title for the team update',
        locale: localeName,
      );

  String get titleView => Intl.message(
    'Team',
    name: "TeamsLocalizations_titleView",
    desc: 'Title for the team view',
    locale: localeName,
  );

  String get labelName => Intl.message(
        "Team Name",
        name: "TeamsLocalizations_labelName",
        desc: 'Label for the team\'s name field',
        locale: localeName,
      );

  String get labelSearchTeams => Intl.message(
        "Search Teams",
        name: "TeamsLocalizations_labelSearchTeams",
        desc: 'Label for the search teams element',
        locale: localeName,
      );

  String get hintName => Intl.message(
        "New Yourk Wolves Byke Den",
        name: "TeamsLocalizations_hintName",
        desc: 'Hint for the team\'s name field',
        locale: localeName,
      );

  String get labelSummary => Intl.message(
        "Team Summary",
        name: "TeamsLocalizations_labelSummary",
        desc: 'Label for the team\'s summary field',
        locale: localeName,
      );

  String get hintSummary => Intl.message(
        "In our team we are making fun, enjoy bikes, high speed and freedom",
        name: "TeamsLocalizations_hintSummary",
        desc: 'Hint for the team\'s summary field',
        locale: localeName,
      );

  String get labelDescription => Intl.message(
        "Team Description",
        name: "TeamsLocalizations_labelDescription",
        desc: 'Label for the team\'s description field',
        locale: localeName,
      );

  String get hintDescription => Intl.message(
        "# New Yourk Wolves Byke Den\n\nWe do the following:\n1. Ride motobykes\n1. Enjoy the speed\n1. Breath the wind",
        name: "TeamsLocalizations_hintSummary",
        desc: 'Hint for the team\'s description field',
        locale: localeName,
      );

  String get labelStatus => Intl.message(
        "Team Activity State",
        name: "TeamsLocalizations_labelStatus",
        desc: 'Label for the team\'s activity state field',
        locale: localeName,
      );

  String get hintStatus => Intl.message(
        "Active",
        name: "TeamsLocalizations_hintStatus",
        desc: 'Hint for the team\'s activity state field',
        locale: localeName,
      );

  String get labelSave => Intl.message(
    "Save",
    name: "TeamsLocalizations_labelSave",
    desc: 'Save button label for a team',
    locale: localeName,
  );

  String get labelStatusActive => Intl.message(
    "Active",
    name: "TeamsLocalizations_labelStatusActive",
    desc: 'Label for a team status Active',
    locale: localeName,
  );

  String get labelStatusPending => Intl.message(
    "Pending",
    name: "TeamsLocalizations_labelStatusPending",
    desc: 'Label for a team status Pending',
    locale: localeName,
  );

  String get labelStatusClosed => Intl.message(
    "Closed",
    name: "TeamsLocalizations_labelStatusClosed",
    desc: 'Label for a team status Closed',
    locale: localeName,
  );

  String get labelVisibilityPublic => Intl.message(
    "Public",
    name: "TeamsLocalizations_labelVisibilityPublic",
    desc: 'Label for team visibility public',
    locale: localeName,
  );

  String get labelVisibilityRegistered => Intl.message(
    "Registered users only",
    name: "TeamsLocalizations_labelVisibilityRegistered",
    desc: 'Label for team visibility registered only',
    locale: localeName,
  );

  String get labelVisibilityGroup => Intl.message(
    "Same team group members",
    name: "TeamsLocalizations_labelVisibilityGroup",
    desc: 'Label for team visibility team group members only',
    locale: localeName,
  );

  String get labelVisibilityMembers => Intl.message(
    "Team members only",
    name: "TeamsLocalizations_labelVisibilityMembers",
    desc: 'Label for team visibility team members only',
    locale: localeName,
  );

  String get labelJoinabilityOwner => Intl.message(
    "Owner",
    name: "TeamsLocalizations_labelJoinabilityOwner",
    desc: 'Label for team joinability: only owner approves the team\'s membership',
    locale: localeName,
  );

  String get labelJoinabilityMember => Intl.message(
    "Member",
    name: "TeamsLocalizations_labelJoinabilityMember",
    desc: 'Label for team joinability: only member of the team approves the team\'s membership',
    locale: localeName,
  );

  String get labelJoinabilityUser => Intl.message(
    "Not required",
    name: "TeamsLocalizations_labelJoinabilityUser",
    desc: 'Label for team joinability: team\'s membership approvements is not required',
    locale: localeName,
  );

  String errorTextFieldLength(String field, int validationNameMinLengh, int length) =>
      Intl.message(
        "The field for $field must be at least $validationNameMinLengh symbols long, while currently it's size is just $length symbols",
        name: "TeamsLocalizations_errorTextFieldLength",
        desc: 'Error for the field name length is too short',
        locale: localeName,
        args: [field, validationNameMinLengh, length],
      );
}

class _TeamsLocalizationsDelegate
    extends LocalizationsDelegate<TeamsLocalizations> {
  const _TeamsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<TeamsLocalizations> load(Locale locale) =>
      TeamsLocalizations.load(locale);

  @override
  bool shouldReload(_TeamsLocalizationsDelegate old) => false;
}
