import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:changepayer_app/app/core/routes/app_pages.dart';
import 'package:changepayer_app/app/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

//Default appbar customized with the design of our app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    this.title = "",
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: context.textTheme.labelMedium,
      ),
      actions: [
        IconButton(
          onPressed: () {
            showOkCancelAlertDialog(
              context: context,
              title: "Logout".tr,
              message: "Could you logout?".tr,
              okLabel: "Confirm".tr,
              defaultType: OkCancelAlertDefaultType.cancel,
            ).then(
              (value) {
                if (value == OkCancelResult.ok) {
                  StorageService.clearSecureStorage();
                  StorageService.clear();
                  Get.offAllNamed(Routes.loginScreen);
                }
              },
            );
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
