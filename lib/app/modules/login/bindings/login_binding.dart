import 'package:get/get.dart';
import 'package:changepayer_app/app/modules/root/controllers/root_controller.dart';
import 'package:changepayer_app/app/modules/login/controllers/login_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<RootController>(
      () => RootController(),
    );
  }
}
