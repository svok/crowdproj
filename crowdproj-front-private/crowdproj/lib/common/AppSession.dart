import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:crypted_preferences/crypted_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:crowdproj/common/Routes.dart';
import 'package:crowdproj/modules/auth/CognitoConfig.dart';
import 'package:crowdproj/modules/auth/AuthService.dart';
import 'package:crowdproj/modules/auth/CognitoSecureStorage.dart';
import 'package:crowdproj/modules/platforms/AppPlatform.dart';

class AppSession {
  AppSession._({
    this.userPool,
    this.securePrefs,
    this.cognitoSecureStorage,
    this.authService,
    this.routes,
    this.locale,
  }) {}

  static AppSession _instance;

  static AppSession get get => _instance;

  static Future<void> init(BuildContext context) async {
    final _securePrefs = await Preferences.preferences(path: 'crowdproj.prefs');

    // Clean up storage for debug mode
//    if (kDebugMode) await _securePrefs.clear();

    final _cognitoSecureStorage = CognitoSecureStorage(_securePrefs);
    final _userPool = CognitoConfig.userPool(_cognitoSecureStorage);
    final _auth = AuthService(_userPool);
    final _routes = Routes(_securePrefs);
    final _locale = _parseLocale(await AppPlatform.getLanguage());
    await _auth.init();

    _instance = AppSession._(
      userPool: _userPool,
      securePrefs: _securePrefs,
      authService: _auth,
      routes: _routes,
      locale: _locale,
    );

//    print("RESOLVING location");
//    final location = await AppPlatform.initLocation();
//    print("RESOLVING location: $location");
//    if (location != null) {
//      Navigator.of(context).pushNamed(location);
//    }
  }

  final CognitoSecureStorage cognitoSecureStorage;
  final CognitoUserPool userPool;
  final Preferences securePrefs;
  final AuthService authService;
  final Routes routes;
  final Locale locale;

  static Locale _parseLocale(String str) {
    final matches = localeRegex.firstMatch(str);
    final language = matches?.group(1);
    final country = matches?.group(2);
    print("Parsing locale for $str -> $language:$country");
    if (language != null) return Locale(language, country);
    return null;
  }
  static final localeRegex = RegExp(r"^([a-z]{2})[-_]?([A-Z]{2})?(?:\..*|)$");
}
