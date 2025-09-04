import 'package:changepayer_app/app/core/base/base_view.dart';
import 'package:changepayer_app/app/core/components/app-bar/custom_app_bar.dart';
import 'package:changepayer_app/app/core/components/text-field/custom_text_form_field.dart';
import 'package:changepayer_app/app/core/network/dio_client.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/root_controller.dart';

class GenerateScreen extends BaseView<RootController> {
  GenerateScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final List<String> listPay = <String>['Pay', 'Receive'];

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(
      title: "Generate Code",
    );
  }

  @override
  Widget body(BuildContext context) {
    return GetBuilder<RootController>(builder: (controller) {
      return SingleChildScrollView(
        physics: MediaQuery.of(context).viewInsets.bottom == 0
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      36.verticalSpace,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Change Type'.tr,
                      style: context.textTheme.bodySmall,
                    ),
                    DropdownMenu<String>(
                      initialSelection: controller.changeType,
                      onSelected: (String? value) {
                        if (value != null) {
                          controller.updateChangeType(value);
                        }
                      },
                      dropdownMenuEntries: listPay.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value,
                            label: value,
                            style: ButtonStyle(
                              textStyle: WidgetStateProperty.all<TextStyle>(
                                TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ));
                      }).toList(),
                      textStyle: context.textTheme.bodySmall,
                      width: 160.sp,
                    ),
                  ],
                ),
                12.verticalSpace,
                Text(
                  'Amount of Change (¢)'.tr,
                  style: context.textTheme.bodySmall,
                ),
                12.verticalSpace,
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
                // 12.verticalSpace,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Authentication'.tr,
                //       style: context.textTheme.bodySmall,
                //     ),
                //     DropdownMenu<String>(
                //       initialSelection: listCode.first,
                //       onSelected: (String? value) {
                //         if (value != null) {
                //           controller.updateAuthenticationType(value);
                //         }
                //       },
                //       dropdownMenuEntries: listCode.map<DropdownMenuEntry<String>>((String value) {
                //         return DropdownMenuEntry<String>(
                //             value: value,
                //             label: value,
                //             style: ButtonStyle(
                //               textStyle: WidgetStateProperty.all<TextStyle>(
                //                 TextStyle(
                //                   fontSize: 18.sp,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ));
                //       }).toList(),
                //       textStyle: context.textTheme.bodySmall,
                //       width: 120.sp,
                //     ),
                //   ],
                // ),
                32.verticalSpace,
                TextButton(
                  onPressed: controller.isLoading.isTrue
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            controller.generateAuthCode();
                          }
                        },
                  child: Text(
                    'GENERATE'.tr,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
