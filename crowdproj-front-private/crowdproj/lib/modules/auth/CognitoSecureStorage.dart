import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:crowdproj/common/IAppPreferences.dart';
import 'dart:convert';

import 'package:crypted_preferences/crypted_preferences.dart';

/// Class handles platform specific storages for the requirements of the login
class CognitoSecureStorage extends CognitoStorage {

  IAppPreferences _securePrefs;

  CognitoSecureStorage(IAppPreferences prefs) {
    _securePrefs = prefs;
  }

  @override
  Future getItem(String key) async {
    String item;
    try {
      item = json.decode(await _securePrefs.getString(key));
    } catch (e) {
      return null;
    }
    return item;
  }

  @override
  Future setItem(String key, value) async {
    await _securePrefs.setString(key, json.encode(value));
    return getItem(key);
  }

  @override
  Future removeItem(String key) async {
    final item = getItem(key);
    if (item != null) {
      await _securePrefs.remove(key);
      return item;
    }
    return null;
  }

  @override
  Future<void> clear() async {
    await _securePrefs.clear();
  }
}
