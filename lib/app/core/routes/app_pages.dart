import 'package:changepayer_app/app/modules/register/bindings/register_binding.dart';
import 'package:changepayer_app/app/modules/register/views/register_screen.dart';
import 'package:changepayer_app/app/modules/root/views/generate_screen.dart';
import 'package:changepayer_app/app/modules/root/views/shop_detail_screen.dart';
import 'package:changepayer_app/app/modules/root/views/verify_screen.dart';
import 'package:get/get.dart';

import 'package:changepayer_app/app/modules/login/bindings/login_binding.dart';
import 'package:changepayer_app/app/modules/login/views/login_screen.dart';
import 'package:changepayer_app/app/modules/root/bindings/root_binding.dart';
import 'package:changepayer_app/app/modules/root/views/root_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.loginScreen;

  static final routes = [
    GetPage(
      name: _Paths.registerScreen,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.loginScreen,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.rootScreen,
      page: () => RootScreen(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.generateScreen,
      page: () => GenerateScreen(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.verifyScreen,
      page: () => VerifyScreen(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.shopDetailScreen,
      page: () => ShopDetailScreen(),
      binding: RootBinding(),
    ),
  ];
}
