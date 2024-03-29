import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:crowdproj/modules/auth/AuthPage.dart';
import 'package:crowdproj/modules/home/HomePage.dart';
import 'package:crowdproj/modules/navigator/LocateToNavigator.dart';
import 'package:crowdproj/modules/promo/PromoPage.dart';
import 'package:crowdproj/modules/auth/CognitoConfig.dart';
import 'package:crowdproj/modules/auth/AuthService.dart';
import 'package:crowdproj/modules/auth/CognitoSecureStorage.dart';
import 'package:crowdproj_common/common/platforms/AppPlatform.dart';
import 'package:crowdproj_common/common/storage/IAppPreferences.dart';
import 'package:crowdproj_teams/crowdproj_teams.dart';
import 'package:crowdproj_teams_models/ITeamsService.dart';
import 'package:crowdproj_teams_rest/rest/TeamsServiceRest.dart';
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

  ITeamsService get teamsService => TeamsModule().transportService;

  static Future<void> init(BuildContext context) async {
    final _securePrefs = AppPlatform.getStorage('crowdproj.prefs');
    await _securePrefs.init();

    // Clean up storage for debug mode
//    if (kDebugMode) await _securePrefs.clear();
    await TeamsModule.init(
//      transportService: TeamsServiceStub(),
      transportService: TeamsServiceRest(basePath: "https://v001-teams.crowdproj.com"),
      locateTo: LocateToNavigator.locateTo,
    );

    final _cognitoSecureStorage = CognitoSecureStorage(_securePrefs);
    final _userPool = CognitoConfig.userPool(_cognitoSecureStorage);
    final _auth = AuthService(_userPool);
    final _locale = _parseLocale(await AppPlatform.getLanguage());
    await _auth.init();


    _instance = AppSession._(
      userPool: _userPool,
      securePrefs: _securePrefs,
      authService: _auth,
      locale: _locale,
    );

    await _instance.resolveHome();
//    await Future.delayed(Duration(seconds: 10));
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
