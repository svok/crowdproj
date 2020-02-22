import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:crowdproj/common/platforms/AppPlatform.dart';
import 'package:crowdproj/common/storage/IAppPreferences.dart';
import 'package:crowdproj/modules/auth/AuthPage.dart';
import 'package:crowdproj/modules/home/HomePage.dart';
import 'package:crowdproj/modules/promo/PromoPage.dart';
import 'package:crowdproj/api/ITeamsService.dart';
import 'package:crowdproj/api/stub/TeamsServiceStub.dart';
import 'package:crowdproj/modules/auth/CognitoConfig.dart';
import 'package:crowdproj/modules/auth/AuthService.dart';
import 'package:crowdproj/modules/auth/CognitoSecureStorage.dart';
import 'package:flutter/material.dart';

class AppSession {
  AppSession._({
    this.userPool,
    this.securePrefs,
    this.cognitoSecureStorage,
    this.authService,
    this.locale,
  }) {}

  final CognitoSecureStorage cognitoSecureStorage;
  final CognitoUserPool userPool;
  final IAppPreferences securePrefs;
  final AuthService authService;
  final Locale locale;

  static AppSession _instance;

  static AppSession get get => _instance;

  ITeamsService _teamsService = TeamsServiceStub();
  ITeamsService get teamsService => _teamsService;

  static Future<void> init(BuildContext context) async {
    print("1");
    final _securePrefs = AppPlatform.getStorage('crowdproj.prefs');
    print("2");
    await _securePrefs.init();

    // Clean up storage for debug mode
//    if (kDebugMode) await _securePrefs.clear();

    print("3");
    final _cognitoSecureStorage = CognitoSecureStorage(_securePrefs);
    print("4");
    final _userPool = CognitoConfig.userPool(_cognitoSecureStorage);
    print("5");
    final _auth = AuthService(_userPool);
    print("6");
    final _locale = _parseLocale(await AppPlatform.getLanguage());
    print("7");
    await _auth.init();
    print("7-aa");

    final xx = AppSession._(
    );

    print("7-ab");
    print("7-ac");

    _instance = AppSession._(
      userPool: _userPool,
      securePrefs: _securePrefs,
      authService: _auth,
      locale: _locale,
    );

    print("8-1");
    await _instance.resolveHome();
//    await Future.delayed(Duration(seconds: 10));
    print("9");
  }

  void setPromoShown() {
    securePrefs.setString(key_promo_shown, "true");
  }

  Widget resolveHome() {
    final isPromoShown =
        securePrefs.getString(key_promo_shown, defaultValue: "false") == "true";
    if (!isPromoShown) {
      return PromoPage();
    }

    final isAuthenticated = authService.isAuthenticated();
    return isAuthenticated ? HomePage() : AuthPage();
  }

  static Locale _parseLocale(String str) {
    final matches = localeRegex.firstMatch(str);
    final language = matches?.group(1);
    final country = matches?.group(2);
    print("Parsing locale for $str -> $language:$country");
    if (language != null) return Locale(language, country);
    return null;
  }

  static final localeRegex = RegExp(r"^([a-z]{2})[-_]?([A-Z]{2})?(?:\..*|)$");
  static const key_promo_shown = "promo_shown";
}
