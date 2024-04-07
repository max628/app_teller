import 'package:changepayer_app/app/core/routes/app_pages.dart';
import 'package:changepayer_app/app/services/storage_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/theme/theme_colors.dart';
import '/app/services/my_hive.dart';
import '/app/models/user_model.dart';
import '/app/core/helper/string_format_helper.dart';
import '/constants/my_images.dart';
import '/app/core/components/asset_image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Default appbar customized with the design of our app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final UserModel? user = MyHive.userBox[MyHive.currentUserKey];

  CustomAppBar({
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
            MyHive.userBox.clear();
            StorageService.clearSecureStorage;
            Get.offAndToNamed(Routes.loginScreen);
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
