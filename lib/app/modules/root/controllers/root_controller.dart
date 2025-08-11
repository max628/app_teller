import 'dart:convert';

import 'package:changepayer_app/app/models/shop_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:changepayer_app/constants/method.dart';
import 'package:changepayer_app/constants/url_container.dart';

// import '/app/services/auth_service.dart';
import '/app/core/base/base_controller.dart';

class RootController extends BaseController {
  final isLoading = true.obs;
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode amountFocusNode = FocusNode();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  var shopItems = <ShopModel>[].obs;
  RxInt selectedShopId = 0.obs;

  @override
  Future<void> onInit() async {
    await refreshSettings();
    super.onInit();
  }

  Future refreshSettings({bool showMessage = false}) async {
    // Get.find<RootController>().getNotificationsCount();
    if (showMessage) {
      showToast("Settings page refreshed successfully".tr);
    }
    isLoading.value = false;

    await getShopList('');
  }

  Future getShopList(String? id) async {
    showLoading();
    final response = await request(
      UrlContainer.shoplist,
      Method.getMethod,
      {},
    );

    if (response.isSuccess) {
      List<dynamic> data = response.responseJson;
      shopItems.value = data.map((item) => ShopModel.fromJson(item)).toList();
      showToast("Set shopItems successfully".tr);
    } else {
      throw Exception('Failed to load items');
    }
    
    hideLoading();
  }

  Future generateAuthCode(String? shopeid, String? amount) async {
    showLoading();
    final response = await request(
      UrlContainer.generatecode,
      Method.postMethod,
      {
        'shopId': shopeid,
        'amount': amount,
      },
    );

    if (response.isSuccess) {
      showToast('Successfully generated authorized code!'.tr);
    } else {
      throw Exception('Failed to generate authorized code.');
    }
    
    hideLoading();
  }

  Future verifyAuthCode(String? code) async {
    showLoading();
    final response = await request(
      UrlContainer.verifycode,
      Method.postMethod,
      {
        'code': code,
      },
    );

    if (response.isSuccess) {
      showToast('Successfully generated authorized code!'.tr);
    } else {
      throw Exception('Failed to generate authorized code.');
    }
    
    hideLoading();
  }
}
