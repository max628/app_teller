import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:changepayer_app/app/core/components/text-field/custom_text_form_field.dart';
import 'package:changepayer_app/app/core/network/dio_client.dart';
import 'package:changepayer_app/app/models/shop_model.dart';
import 'package:changepayer_app/app/models/user_model.dart';
import 'package:changepayer_app/app/services/my_hive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:changepayer_app/app/core/components/app-bar/custom_app_bar.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '/app/core/base/base_view.dart';

import '../controllers/root_controller.dart';
class RootScreen extends BaseView<RootController> {  
  RootScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final UserModel? user = MyHive.userBox[MyHive.currentUserKey];

  List<String> listPay = <String>['Pay', 'Receive'];
  List<String> listCode = <String>['NFC', 'Code'];  
  
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      title: "Change Payer 2",
    );
  }

  ValueNotifier<dynamic> _nfcData = ValueNotifier(null);
  String changeType = "Pay";
  void _startNFCSession() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      _nfcData.value = tag.data;
      NfcManager.instance.stopSession();
    });
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
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      'First Name'.tr,
                      style: context.textTheme.bodySmall,
                    ),
                    Text(
                      user?.venue?.name ?? "",
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      'Last Name'.tr,
                      style: context.textTheme.bodySmall,
                    ),
                    Text(
                      user?.venue?.name ?? "",
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shop Name'.tr,
                      style: context.textTheme.bodySmall,
                    ),
                    Obx((){
                      return DropdownMenu<dynamic>(
                            initialSelection: controller.selectedShopId,
                            onSelected: (dynamic value) {
                              controller.selectedShopId.value = value!;
                            },
                            dropdownMenuEntries: controller.shopItems.map<DropdownMenuEntry<dynamic>>((ShopModel item) {
                              return DropdownMenuEntry<dynamic>(value: item.id, label: item.name, style: ButtonStyle(
                                textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),),
                                ));
                            }).toList(),
                            textStyle: context.textTheme.bodySmall,
                            width: 120.sp,                     
                          );
                    }),                    
                  ],
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
                      initialSelection: listPay.first,
                      onSelected: (String? value) {
                        
                      },
                      dropdownMenuEntries: listPay.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(value: value, label: value, style: ButtonStyle(
                          textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),),
                          ));
                      }).toList(),
                      textStyle: context.textTheme.bodySmall,
                      width: 120.sp,                     
                    ),
                  ],
                ),
                12.verticalSpace,
                Text(
                  'Amount of Change'.tr,
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
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Authentication'.tr,
                      style: context.textTheme.bodySmall,
                    ),
                    DropdownMenu<String>(
                      initialSelection: listCode.first,
                      onSelected: (String? value) {
                        
                      },
                      dropdownMenuEntries: listCode.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(value: value, label: value, style: ButtonStyle(
                          textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),),
                          ));
                      }).toList(),
                      textStyle: context.textTheme.bodySmall,
                      width: 120.sp,
                      
                    ),
                  ],
                ),
                const SizedBox(
                  height: 33,
                ),
                TextButton(
                  onPressed: controller.isLoading.isTrue
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            
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
