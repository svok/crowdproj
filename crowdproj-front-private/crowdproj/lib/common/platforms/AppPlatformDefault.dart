import 'dart:io';
import 'package:crowdproj/common/storage/AppPreferencesCrypted.dart';
import 'package:crowdproj/common/storage/AppPreferencesShared.dart';
import 'package:crowdproj/common/storage/IAppPreferences.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';

class AppPlatform {
  void setupRuntimeEnvironment() {
    TargetPlatform targetPlatform;
    if (Platform.isMacOS) {
      targetPlatform = TargetPlatform.iOS;
    } else if (Platform.isLinux || Platform.isWindows) {
      targetPlatform = TargetPlatform.android;
    } else {
      targetPlatform = TargetPlatform.fuchsia;
    }
    if (targetPlatform != null) {
      debugDefaultTargetPlatformOverride = targetPlatform;
    }
  }

  void configWindow(String data, String title, String path) {}

  Future<String> initLocation() async => null;

  Future<String> getLanguage() async {
    if (Platform.isAndroid || Platform.isIOS) {
      return await Devicelocale.currentLocale;
    }

    return Platform.environment["LANG"] ??
        Platform.environment["LANGUAGE"] ??
        Platform.environment["LC_ALL"];
  }

  IAppPreferences getStorage(String dbName) {
    if (Platform.isLinux || Platform.isWindows) {
      return AppPreferencesCrypted(dbName: dbName);
    }
    return AppPreferencesShared(dbName: dbName);
  }
}
