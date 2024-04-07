abstract class Flavor {
  static const String dev = 'development';
  static const String prod = 'production';
  static const String stag = 'staging';
  static const String admin = 'admin';

  String get name;
}

class Development implements Flavor {
  @override
  String get name => Flavor.dev;
}

class Production implements Flavor {
  @override
  String get name => Flavor.prod;
}

class Staging implements Flavor {
  @override
  String get name => Flavor.stag;
}

class Admin implements Flavor {
  @override
  String get name => Flavor.admin;
}

class Config {
  Config._();

  static late Flavor appFlavor;
  static AppMode appMode = _getCurrentMode();

  static AppMode _getCurrentMode() {
    AppMode _mode;

    bool isDebug = false;
    assert(isDebug = true);

    if (isDebug) {
      _mode = AppMode.debug;
    } else if (const bool.fromEnvironment('dart.vm.product')) {
      _mode = AppMode.release;
    } else {
      _mode = AppMode.profile;
    }

    return _mode;
  }
}

enum AppMode {
  debug,
  release,
  profile,
}
