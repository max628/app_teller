import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:changepayer_app/app/core/components/app-bar/custom_app_bar.dart';
import 'package:changepayer_app/app/core/routes/app_pages.dart';
import 'package:changepayer_app/app/modules/root/views/shop_list_view.dart';
import 'package:changepayer_app/app/services/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/app/core/base/base_view.dart';

import '../controllers/root_controller.dart';

class RootScreen extends BaseView<RootController> {
  RootScreen({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
      title: "ChangePayer",
    );
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    final isShopper = StorageService.getIsShopper();
    return isShopper
        ? GetBuilder<RootController>(
            builder: (controller) => Padding(
              padding: EdgeInsets.all(20.sp),
              child: TextButton(
                onPressed: () async {
                  Get.toNamed(Routes.verifyScreen);
                },
                child: const Text("Pay or Receive change"),
              ),
            ),
          )
        : null;
  }

  @override
  Widget body(BuildContext context) {
    DateTime? currentBackPressTime;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, _) {
        if (didPop) {
          return;
        }
        if (scaffoldGlobalKey.currentState!.isDrawerOpen) {
          Navigator.of(context).pop();
          return;
        }
        final now = DateTime.now();
        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          return;
        }
        showOkCancelAlertDialog(
          context: context,
          title: "Turn off app".tr,
          message: "Could you turn off app?".tr,
          okLabel: "Confirm".tr,
          defaultType: OkCancelAlertDefaultType.cancel,
        ).then(
          (value) => {if (value == OkCancelResult.ok) SystemNavigator.pop()},
        );
      },
      child: const SafeArea(
        child: Scrollbar(
          child: ShopListView(),
        ),
      ),
    );
  }
}
