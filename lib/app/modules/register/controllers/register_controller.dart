import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/app/models/user_model.dart';
import '/constants/method.dart';
import '/constants/url_container.dart';
import '/app/services/storage_service.dart';
import '/app/core/base/base_controller.dart';
import '/app/core/routes/app_pages.dart';

class RegisterController extends BaseController {
  RxBool showRegisterContent = false.obs;
  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs;
  List<ConnectivityResult> connectivityResult = [ConnectivityResult.none];

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    connectivityResult = await Connectivity().checkConnectivity();
  }

  Future signIn() async {
    isLoading.value = true;
    showLoading();
    final response = await request(
      UrlContainer.register,
      Method.postMethod,
      {
        "username": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      },
    );

    if (response.statusCode == 200 && response.responseJson != null) {
      final jwtToken = response.responseJson['token'] as String;
      StorageService.setAccessToken(jwtToken);
      if (response.responseJson['user'] != null) {
        final user = UserModel.fromJson(response.responseJson['user']);
        await StorageService.setIsShopper(user.role.toLowerCase() == "shopper");
        await StorageService.setUsername(user.name);
        await StorageService.setEmail(user.email);
        showToast('Register Success!'.tr);
        Get.offAndToNamed(Routes.rootScreen);
      } else {
        throw Exception('Failed to load user');
      }
    } else {
      showToast('Register Failed! Please check register details or ask to server manager.'.tr);
    }
    hideLoading();
    isLoading.value = false;
  }
}
