import 'package:changepayer_app/app/core/network/dio_client.dart';
import 'package:changepayer_app/app/modules/root/controllers/root_controller.dart';
import 'package:changepayer_app/constants/my_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class QrCodeDialog extends StatelessWidget {
  const QrCodeDialog({
    super.key,
    this.code = "",
  });
  final String code;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(builder: (controller) {
      return PopScope(
        canPop: false,
        child: Stack(
          children: [
            Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                child: Dialog.fullscreen(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Column(
                        children: [
                        ],
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
          ],
        ),
      );
    });
  }
}
