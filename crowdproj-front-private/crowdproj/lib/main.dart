import 'package:flutter/material.dart';

import 'MainApp.dart';
import 'common/platforms/AppPlatform.dart';

void main() {
  AppPlatform.setupRuntimeEnvironment();
  runApp(MainApp());
}
