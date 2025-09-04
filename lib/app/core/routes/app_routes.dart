part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const loginScreen = _Paths.loginScreen;
  static const registerScreen = _Paths.registerScreen;
  static const rootScreen = _Paths.rootScreen;
  static const verifyScreen = _Paths.verifyScreen;
  static const generateScreen = _Paths.generateScreen;
  static const shopDetailScreen = _Paths.shopDetailScreen;
}

abstract class _Paths {
  _Paths._();
  static const loginScreen = '/login_screen';
  static const registerScreen = '/register_screen';
  static const rootScreen = '/root_screen';
  static const verifyScreen = '/verify_screen';
  static const generateScreen = '/generate_screen';
  static const shopDetailScreen = '/shop_detail_screen';
}
