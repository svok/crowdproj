import 'package:crowdproj/common/storage/IAppPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesShared extends IAppPreferences {
  AppPreferencesShared({this.dbName: ".pref"}) : super();
  String dbName;
  SharedPreferences _preferences;

  String _normKey(String key) => "$dbName.$key";

  @override
  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  String getString(String key, {String defaultValue}) =>
      _preferences.getString(_normKey(key)) ?? defaultValue;

  @override
  Future setString(String key, String value) =>
      _preferences.setString(_normKey(key), value);

  @override
  Future clear() => _preferences.clear();

  @override
  Future remove(String key) => _preferences.remove(_normKey(key));
}
