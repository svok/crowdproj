import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MainApp.dart';
import 'modules/auth/AuthService.dart';
import 'modules/platforms/AppPlatform.dart';

void main() {
  AppPlatform.setupRuntimeEnvironment();
//  await AppSession.init();
  runApp(MainApp());
}
