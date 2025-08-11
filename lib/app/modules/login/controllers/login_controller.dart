import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';

import '/app/models/user_model.dart';
import '/constants/method.dart';
import '/constants/url_container.dart';
import '/app/services/storage_service.dart';
import '/app/services/my_hive.dart';
import '/app/core/base/base_controller.dart';
import '/app/core/routes/app_pages.dart';

class LoginController extends BaseController {
  RxBool showLoginContent = false.obs;
  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs;
  List<ConnectivityResult> connectivityResult = [ConnectivityResult.none];

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

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
      UrlContainer.login,
      Method.postMethod,
      {
        "email": emailController.text,
        "password": passwordController.text,
      },
    );

    showToast(
      response.statusCode.toString(),
    );
    
    if (response.statusCode == 200 && response.responseJson != null) {
      // final session = response.responseJson['data']['session'];
      // MyHive.userBox.put(MyHive.currentUserKey, UserModel.fromJson(session));
      showToast('Login Success!'.tr);
      StorageService.setAccessToken(response.responseJson['token'].toString());
      Get.offAndToNamed(Routes.rootScreen);
    } else {
      showToast('Login Failed! Please check login details or ask to server manager.'.tr);
    }
    // final List<dynamic> jsonList = jsonDecode(jsonData);
    // final devices = jsonList.map((json) => Device.fromJson(json)).toList();
    hideLoading();
    isLoading.value = false;
  }
}
