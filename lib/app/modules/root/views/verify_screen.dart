import 'package:changepayer_app/app/core/components/text-field/custom_text_form_field.dart';
import 'package:changepayer_app/constants/my_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:changepayer_app/app/core/components/app-bar/custom_app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart'; // Add this import

import '/app/core/base/base_view.dart';

import '../controllers/root_controller.dart';

class VerifyScreen extends BaseView<RootController> {
  VerifyScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
      title: "Verify Code",
    );
  }

  @override
  Widget body(BuildContext context) {
    return GetBuilder<RootController>(builder: (controller) {
      return SizedBox(
        height: Get.height,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(18.sp),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Code'.tr,
                      style: context.textTheme.bodySmall,
                    ),
                    15.verticalSpace,
                    CustomTextFormField(
                      hintText: ' ',
                      controller: controller.codeController,
                      inputAction: TextInputAction.done,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '${'Please enter Code'.tr} ';
                        } else {
                          return null;
                        }
                      },
                    ),
                    32.verticalSpace,
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        controller.readNFC();
                      },
                      child: Text(
                        'NFC Scan'.tr,
                      ),
                    ),
                    12.verticalSpace,
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {
                        Get.to(() => Scaffold(
                                body: QRCodeDartScanView(
                              // typeCamera: ,
                              // typeScan: TypeScan.takePicture,
                              takePictureButtonBuilder: (context, controller, isLoading) {
                                // if typeScan == TypeScan.takePicture you can customize the button.
                                if (isLoading) return CircularProgressIndicator();
                                return ElevatedButton(
                                  onPressed: controller.takePictureAndDecode,
                                  child: Text('Take a picture'),
                                );
                              },
                              onCapture: (result) {
                                debugPrint(result.text);
                                controller.codeController.text = result.text;
                                Get.back();
                              },
                            )));
                      },
                      child: Text('Scan Qr Code'.tr),
                    ),
                    12.verticalSpace,
                    TextButton(
                      onPressed: controller.isLoading.isTrue
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                controller.verifyAuthCode();
                              }
                            },
                      child: Text(
                        'VERIFY'.tr,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.nftScanning.isTrue
                  ? Material(
                      color: Colors.black.withValues(alpha: 0.5),
                      child: Center(
                        child: Container(
                          width: 300.sp,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(20.sp),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                MyImages.nfcAnimation,
                                height: 80.sp,
                              ),
                              20.verticalSpace,
                              Text(
                                'Approach to read data',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18.sp,
                                ),
                              ),
                              20.verticalSpace,
                              ElevatedButton(
                                onPressed: () => controller.nfcCancel(),
                                child: Text('Cancel'.tr),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
    });
  }
}
