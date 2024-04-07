import 'package:changepayer_app/app/core/components/text-field/custom_text_form_field.dart';
import 'package:changepayer_app/constants/my_images.dart';
import 'package:flutter/material.dart';

import 'package:changepayer_app/app/core/base/base_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends BaseView<LoginController> {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
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
                    Image.asset(
                      MyImages.appLogoImageRemovebg,
                      height: 80.sp,
                    ),
                    Text(
                      'Changepayer'.tr,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: 32.sp,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                'Email'.tr,
                style: context.textTheme.bodySmall,
              ),
              CustomTextFormField(
                controller: controller.emailController,
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                focusNode: controller.emailFocusNode,
                hintText: ' ',
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return '${'Please enter email'.tr} ';
                  } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+", caseSensitive: false).hasMatch(value)) {
                    return '${'Please enter correct email'.tr} ';
                  } else {
                    return null;
                  }
                },
                nextFocus: controller.passwordFocusNode,
              ),
              12.verticalSpace,
              Text(
                'Password'.tr,
                style: context.textTheme.bodySmall,
              ),
              CustomTextFormField(
                hintText: ' ',
                isPassword: true,
                controller: controller.passwordController,
                inputAction: TextInputAction.done,
                focusNode: controller.passwordFocusNode,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return '${'Please enter password'.tr} ';
                  } else {
                    return null;
                  }
                },
              ),
              33.verticalSpace,
              TextButton(
                onPressed: controller.isLoading.isTrue
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          controller.signIn();
                        }
                      },
                child: Text('LOGIN NOW'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
