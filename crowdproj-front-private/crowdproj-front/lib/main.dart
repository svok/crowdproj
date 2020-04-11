import 'package:crowdproj_common/common/platforms/AppPlatform.dart';
import 'package:flutter/material.dart';

import 'MainApp.dart';

void main() {
  AppPlatform.setupRuntimeEnvironment();
  runApp(MainApp());
}
