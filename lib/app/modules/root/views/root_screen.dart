import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:changepayer_app/app/core/components/text-field/custom_text_form_field.dart';
import 'package:changepayer_app/app/core/network/dio_client.dart';
import 'package:changepayer_app/app/models/user_model.dart';
import 'package:changepayer_app/app/services/my_hive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upgrader/upgrader.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:changepayer_app/app/core/components/app-bar/custom_app_bar.dart';
import 'package:changepayer_app/app/services/storage_service.dart';
import 'package:changepayer_app/constants/my_icons.dart';
import 'package:changepayer_app/translations/localization_service.dart';
import 'package:changepayer_app/translations/strings_enum.dart';

import '/app/core/base/base_view.dart';

import '../controllers/root_controller.dart';

class RootScreen extends BaseView<RootController> {
  RootScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final UserModel? user = MyHive.userBox[MyHive.currentUserKey];

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      title: "Add Ticket",
    );
  }

  @override
  Widget body(BuildContext context) {
    DateTime? currentBackPressTime;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
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
          okLabel: "confirm".tr,
          defaultType: OkCancelAlertDefaultType.cancel,
        ).then(
          (value) => {if (value == OkCancelResult.ok) SystemNavigator.pop()},
        );
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      user?.venue?.logo != null
                          ? Image.network(
                              '${DioClient.baseUrl}${user?.venue?.logo}',
                              height: 120.sp,
                            )
                          : Container(),
                      12.verticalSpace,
                      Text(
                        user?.venue?.name ?? "",
                        // style: context.textTheme.titleSmall?.copyWith(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'Phone Number'.tr,
                  style: context.textTheme.bodySmall,
                ),
                CustomTextFormField(
                  hintText: ' ',
                  controller: controller.phoneNumberController,
                  inputType: TextInputType.phone,
                  inputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[\d\- ]*$')),
                  ],
                  focusNode: controller.phoneNumberFocusNode,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '${'Please enter Phone Number'.tr} ';
                    } else {
                      return null;
                    }
                  },
                  nextFocus: controller.amountFocusNode,
                ),
                12.verticalSpace,
                Text(
                  'Change Amount'.tr,
                  style: context.textTheme.bodySmall,
                ),
                CustomTextFormField(
                  hintText: ' ',
                  controller: controller.amountController,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  inputAction: TextInputAction.done,
                  focusNode: controller.amountFocusNode,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '${'Please enter amount'.tr} ';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 33,
                ),
                TextButton(
                  onPressed: controller.isLoading.isTrue
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            controller.addTicket(user?.venue?.id);
                          }
                        },
                  child: Text(
                    'SAVE'.tr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
