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
  }

  Future addTicket(String? id) async {
    showLoading();
    final response = await request(
      UrlContainer.addticket,
      Method.postMethod,
      {
        "venue": id,
        "phone_number": phoneNumberController.text,
        "amount": amountController.text,
      },
    );
    if (response.isSuccess) {
      showToast("new ticket added");
      // final data = json.decode(response.body);
      // print(data);
    }
    hideLoading();
  }
}
