import 'dart:html' as html;

import 'package:crowdproj/common/storage/AppPreferencesShared.dart';
import 'package:crowdproj/common/storage/IAppPreferences.dart';
//import 'dart:js' as js; // only if you want to do Js logic

class AppPlatform {
  void setupRuntimeEnvironment() {}

  void configWindow(String data, String title, String path) {
    html.document.title = title;
    html.window.history.pushState("", title, "/#$path");
  }

  Future<String> initLocation() async {
    print("CURREN LOCATION: ${html.window.location.hash}");
    return html.window.location.hash;
  }

  Future<String> getLanguage() async => html.window.navigator.language;

  IAppPreferences getStorage(String dbName) =>
      AppPreferencesShared(dbName: dbName);
}
