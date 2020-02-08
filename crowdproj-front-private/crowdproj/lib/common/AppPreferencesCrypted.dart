import 'package:crowdproj/common/IAppPreferences.dart';
import 'package:crypted_preferences/crypted_preferences.dart';

class AppPreferencesCrypted extends IAppPreferences {
  AppPreferencesCrypted({
    this.dbName: ".prefs",
  }) : super();

  final String dbName;
  Preferences _preferences;

  @override
  Future init() async {
    _preferences = await Preferences.preferences(path: dbName);
  }

  @override
  String getString(String key, {String defaultValue}) =>
      _preferences.getString(key, defaultValue: defaultValue);

  @override
  Future setString(String key, String value) =>
      _preferences.setString(key, value);

  @override
  Future clear() => _preferences.clear();

  @override
  Future remove(String key) => _preferences.remove(key);
}
