import 'package:changepayer_app/app/core/network/dio_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:changepayer_app/app/core/components/app-bar/custom_app_bar.dart';

import '/app/core/base/base_view.dart';

import '../controllers/root_controller.dart';

class ShopDetailScreen extends BaseView<RootController> {
  ShopDetailScreen({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
      title: "Shop Detail",
    );
  }

  @override
  Widget body(BuildContext context) {
    return GetBuilder<RootController>(builder: (controller) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.selectedShop?.logo != null && controller.selectedShop!.logo.isNotEmpty
                        ? Image.network(
                            '${DioClient.baseUrl}${controller.selectedShop?.logo}',
                            height: 120.sp,
                          )
                        : const SizedBox(),
                    12.verticalSpace,
                    Text(
                      controller.selectedShop?.name ?? "",
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: 28.sp,
                      ),
                    ),
                  ],
                ),
              ),
              12.verticalSpace,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Address: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    TextSpan(
                      text: controller.selectedShop?.address ?? "",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
              12.verticalSpace,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Phone Number: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    TextSpan(
                      text: controller.selectedShop?.phoneNumber ?? "",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
              12.verticalSpace,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Contact: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    TextSpan(
                      text: controller.selectedShop?.contact ?? "",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
              12.verticalSpace,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Balance: ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    TextSpan(
                      text: "\$${controller.selectedShop?.balance.toString() ?? "0.0"}",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
