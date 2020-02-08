import 'AppPlatformDefault.dart' if (dart.library.html) 'AppPlatformWeb.dart' as Lib;

final AppPlatform = Lib.AppPlatform();
