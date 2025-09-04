import 'package:changepayer_app/app/core/components/text-field/custom_text_form_field.dart';
import 'package:changepayer_app/app/core/routes/app_pages.dart';
import 'package:changepayer_app/constants/my_images.dart';
import 'package:flutter/material.dart';

import 'package:changepayer_app/app/core/base/base_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:url_launcher/url_launcher.dart';
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
      child: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: MediaQuery.of(context).viewInsets.bottom == 0
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //     width: 481.sp,
                    //     height: 452.sp,
                    //     // child: MobileScanner(
                    //     //   onDetect: (capture) {
                    //     //     final List<Barcode> barcodes = capture.barcodes;
                    //     //     for (final barcode in barcodes) {
                    //     //       print(barcode.rawValue);
                    //     //     }
                    //     //   },
                    //     // ),
                    //     child: QRCodeDartScanView(
                    //       // typeCamera: ,
                    //       // typeScan: TypeScan.takePicture,
                    //       takePictureButtonBuilder: (context, controller, isLoading) {
                    //         // if typeScan == TypeScan.takePicture you can customize the button.
                    //         if (isLoading) return CircularProgressIndicator();
                    //         return ElevatedButton(
                    //           onPressed: controller.takePictureAndDecode,
                    //           child: Text('Take a picture'),
                    //         );
                    //       },
                    //       onCapture: (result) {
                    //         debugPrint(result.text);
                    //         // Get.back();
                    //       },
                    //     )),
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //     backgroundColor: Colors.amber,
                    //   ),
                    //   onPressed: () {
                    //     Get.to(() => Scaffold(
                    //             body: QRCodeDartScanView(
                    //           // typeCamera: ,
                    //           // typeScan: TypeScan.takePicture,
                    //           takePictureButtonBuilder: (context, controller, isLoading) {
                    //             // if typeScan == TypeScan.takePicture you can customize the button.
                    //             if (isLoading) return CircularProgressIndicator();
                    //             return ElevatedButton(
                    //               onPressed: controller.takePictureAndDecode,
                    //               child: Text('Take a picture'),
                    //             );
                    //           },
                    //           onCapture: (result) {
                    //             debugPrint(result.text);
                    //             Get.back();
                    //           },
                    //         )));
                    //   },
                    //   child: Text('Scan Qr Code'.tr),
                    // ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            MyImages.appLogoImageRemovebg,
                            height: 160.sp,
                          ),
                          Text(
                            'ChangePayer'.tr,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontSize: 32.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
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
                        } else if (!RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+", caseSensitive: false)
                            .hasMatch(value)) {
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
                      child: Text('LOGIN'.tr),
                    ),
                    24.verticalSpace,
                    GestureDetector(
                      onTap: () async {
                        final url = Uri.parse('https://changepayer.com/forgot-password');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        'Forgot Password?',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.theme.primaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    12.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?'.tr,
                          style: context.textTheme.bodySmall?.copyWith(fontSize: 16.sp),
                        ),
                        GestureDetector(
                          onTap: controller.isLoading.isTrue
                              ? null
                              : () {
                                  Get.toNamed(Routes.registerScreen);
                                },
                          child: Text(
                            ' Register Now',
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: context.theme.primaryColor, fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
