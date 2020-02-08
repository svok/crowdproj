abstract class IAppPreferences {

  Future init();
  String getString(String key, {String defaultValue});
  Future setString(String key, String value);
  Future remove(String key);
  Future clear();
}
