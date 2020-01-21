import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MainApp.dart';
import 'modules/platforms/AppPlatform.dart';

void main() {
  AppPlatform.setupRuntimeEnvironment();
//  await AppSession.init();
  runApp(MainApp());
}
