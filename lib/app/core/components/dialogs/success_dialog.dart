import 'package:changepayer_app/app/core/network/dio_client.dart';
import 'package:changepayer_app/app/modules/root/controllers/root_controller.dart';
import 'package:changepayer_app/constants/my_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    super.key,
    this.content,
    this.title = "",
    this.message = "",
    this.code = "",
  });
  final Widget? content;

  final String title;
  final String message;
  final String code;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(builder: (controller) {
      final isVerify = title.contains('verified');
      return PopScope(
        canPop: false,
        child: Stack(
          children: [
            Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                child: Dialog.fullscreen(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: SizedBox(
                    height: Get.height,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: Column(
                            children: [
                              // Image.asset(MyImages.appLogo, fit: BoxFit.contain, height: 60.sp, width: 100.sp),
                              Visibility(
                                visible: isVerify,
                                child: SvgPicture.asset('assets/icons/check.svg', width: 130.sp, height: 130.sp),
                              ),
                              Visibility(
                                visible: !isVerify,
                                child: 16.verticalSpace,
                              ),
                              Visibility(
                                visible: !isVerify,
                                child: QrImageView(
                                  data: code,
                                  version: QrVersions.auto,
                                  size: 240.sp,
                                ),
                              ),
                              24.verticalSpace,
                              Column(
                                children: [
                                  Text(
                                    title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  message.isNotEmpty
                                      ? Column(children: [
                                          16.verticalSpace,
                                          Text(
                                            message,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ])
                                      : const SizedBox.shrink(),
                                  16.verticalSpace,
                                  Text(
                                    code,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      controller.selectedShop?.logo != null && controller.selectedShop!.logo.isNotEmpty
                                          ? Image.network(
                                              '${DioClient.baseUrl}${controller.selectedShop?.logo}',
                                              height: 40.sp,
                                            )
                                          : const SizedBox(),
                                      12.horizontalSpace,
                                      Text(
                                        "Changepayer",
                                        style: context.textTheme.titleSmall?.copyWith(
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              40.verticalSpace,
                              Visibility(
                                visible: !isVerify,
                                child: SizedBox(
                                  width: 170.w,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.sp),
                                      ),
                                    ),
                                    onPressed: () => controller.writeNFC(code),
                                    child: Text('Share to NFC'.tr),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !isVerify,
                                child: 16.verticalSpace,
                              ),
                              // Visibility(
                              //   visible: !isVerify,
                              //   child: SizedBox(
                              //     width: 170.w,
                              //     child: ElevatedButton(
                              //       style: ElevatedButton.styleFrom(
                              //         backgroundColor: Colors.amber,
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(10.sp),
                              //         ),
                              //       ),
                              //       onPressed: () => controller.showQrCode.value = true,
                              //       child: Text('Share to Qr Code'.tr),
                              //     ),
                              //   ),
                              // ),
                              // Visibility(
                              //   visible: !isVerify,
                              //   child: 16.verticalSpace,
                              // ),
                              SizedBox(
                                width: 170.w,
                                child: ElevatedButton(
                                  onPressed: () => {
                                    controller.refreshScreen(),
                                    Get.back(),
                                  },
                                  child: Text('Back to Home'.tr),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.nftScanning.isTrue
                  ? Container(
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
                                'Approach to write data',
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
            // Obx(
            //   () => controller.showQrCode.isTrue
            //       ? Container(
            //           color: Colors.black.withValues(alpha: 0.5),
            //           child: Center(
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 color: Theme.of(context).scaffoldBackgroundColor,
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               padding: EdgeInsets.all(20.sp),
            //               child: Column(
            //                 children: [
            //                   QrImageView(
            //                     data: code,
            //                     version: QrVersions.auto,
            //                     size: 300.sp,
            //                   ),
            //                   12.verticalSpace,
            //                   Text(
            //                     code,
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       fontSize: 20.sp,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         )
            //       : const SizedBox.shrink(),
            // ),
          ],
        ),
      );
    });
  }
}
