import 'package:changepayer_app/app/core/components/dialogs/success_dialog.dart';
import 'package:changepayer_app/app/core/routes/app_pages.dart';
import 'package:changepayer_app/app/models/shop_model.dart';
import 'package:changepayer_app/app/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:changepayer_app/constants/method.dart';
import 'package:changepayer_app/constants/url_container.dart';
import 'package:nfc_manager/platform_tags.dart';

// import '/app/services/auth_service.dart';
import '/app/core/base/base_controller.dart';

class RootController extends BaseController {
  final isLoading = true.obs;
  final nftScanning = false.obs;
  final showQrCode = false.obs;
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode amountFocusNode = FocusNode();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  List<ShopModel> shopItems = [];
  ShopModel? selectedShop;

  final ValueNotifier<dynamic> _nfcData = ValueNotifier(null);
  String changeType = "Receive";

  Future<void> readNFC() async {
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();

      // We first check if NFC is available on the device.
      if (isAvailable) {
        // If NFC is available, start an NFC session and listen for NFC tags to be discovered.
        nftScanning.value = true;
        await NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            // Process NFC tag, When an NFC tag is discovered, print its data to the console.
            debugPrint('NFC Tag Detected: ${tag.data}');
            showToast('NFC Tag Detected: ${tag.data}');

            // Check if the tag supports NDEF
            var ndef = Ndef.from(tag);
            if (ndef == null) {
              debugPrint('Tag is not NDEF compatible');
              showToast('Tag is not NDEF compatible');
              NfcManager.instance.stopSession();
              nftScanning.value = false;
              return;
            }
            // Check if the tag supports NDEF
            var ndea = NfcA.from(tag);
            if (ndea == null) {
              debugPrint('Tag is not NDEA compatible');
              showToast('Tag is not NDEA compatible');
              NfcManager.instance.stopSession();
              nftScanning.value = false;
              return;
            }

            // Read NDEF message
            NdefMessage message = await ndef.read();
            String code = String.fromCharCodes(message.records.first.payload);
            debugPrint('Read code: $code');
            showToast('Read code: $code');
            _nfcData.value = code;
            codeController.text = code;

            // Stop the NFC Session
            NfcManager.instance.stopSession();
            nftScanning.value = false;
          },
          onError: (e) async {
            debugPrint('Error emitting NFC data: $e');
            showToast('Error emitting NFC data: ${e.message}');

            NfcManager.instance.stopSession();
            nftScanning.value = false;
          },
        );
      } else {
        debugPrint('NFC not available.');
        showToast('NFC not available.');
      }
    } catch (e) {
      debugPrint('Error reading NFC: $e');
      showToast('Error reading NFC: $e');
    }
  }

  Future<void> writeNFC(String code) async {
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();

      // We first check if NFC is available on the device.
      if (isAvailable) {
        nftScanning.value = true;
        await NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            try {
              // When an NFC tag is discovered, we check if it supports NDEF technology.
              var ndef = Ndef.from(tag);
              if (ndef == null) {
                debugPrint('Tag is not NDEF compatible');
                showToast('Tag is not NDEF compatible');
                NfcManager.instance.stopSession();
                nftScanning.value = false;

                return;
              }

              // Create an NDEF message and write it to the tag.
              NdefMessage message = NdefMessage([NdefRecord.createText(code)]);
              await ndef.write(message);
              debugPrint('Data emitted successfully');
              showToast('Data emitted successfully');

              // Stop the NFC Session
              NfcManager.instance.stopSession();
              nftScanning.value = false;
            } catch (e) {
              debugPrint('Error emitting NFC data: $e');
              showToast('Error emitting NFC data: ${e.toString()}');
              NfcManager.instance.stopSession();
              nftScanning.value = false;
            }
          },
          // pollingOptions: {
          //   NfcPollingOption.iso14443,
          //   NfcPollingOption.iso15693,
          //   NfcPollingOption.iso18092,
          // },
          alertMessage: 'Hold your device near the NFC tag.',
          onError: (e) async {
            debugPrint('Error emitting NFC data: $e');
            showToast('Error emitting NFC data: ${e.message}');

            NfcManager.instance.stopSession();
            nftScanning.value = false;
          },
          invalidateAfterFirstRead: true,
        );
      } else {
        debugPrint('NFC not available.');
        showToast('NFC not available.');
      }
    } catch (e) {
      debugPrint('Error writing NFC: $e');
      showToast('Error writing NFC: $e');
    }
  }

  void nfcCancel() {
    NfcManager.instance.stopSession();
    nftScanning.value = false;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    showLoading();
    await refreshScreen();
    hideLoading();
  }

  Future refreshScreen({bool showMessage = false}) async {
    // Get.find<RootController>().getNotificationsCount();
    if (showMessage) {
      showToast("Settings page refreshed successfully".tr);
    }
    await getShopList();
  }

  Future getShopList() async {
    isLoading.value = true;
    final response = await request(
      UrlContainer.shoplist,
      Method.getMethod,
      {},
    );

    if (response.isSuccess) {
      List<dynamic> data = response.responseJson;
      shopItems = data.map((item) => ShopModel.fromJson(item)).toList();
      selectedShop = shopItems[0];
      // showToast("Set shop items successfully".tr);
    } else {
      showToast("Failed to get shop items".tr);
    }

    isLoading.value = false;
    update();
  }

  void selectShop(ShopModel shop) {
    selectedShop = shop;
    final isShopper = StorageService.getIsShopper();
    if (isShopper) {
      Get.toNamed(Routes.shopDetailScreen);
    } else {
      Get.toNamed(Routes.generateScreen);
    }
    update();
  }

  Future generateAuthCode() async {
    showLoading();
    final response = await request(
      UrlContainer.generatecode,
      Method.postMethod,
      {
        'shopId': selectedShop?.id,
        'amount': changeType == 'Pay'
            ? -double.parse(amountController.text) / 100
            : double.parse(amountController.text) / 100,
      },
    );
    hideLoading();

    if (response.isSuccess) {
      Get.to(
        () => SuccessDialog(
          title: 'Successfully generated code!'.tr,
          code: response.responseJson['code'].toString(),
        ),
      );
    } else {
      showToast('Failed to generate code.');
    }
  }

  Future verifyAuthCode() async {
    showLoading();
    final response = await request(
      UrlContainer.verifycode,
      Method.postMethod,
      {
        'code': codeController.text,
      },
    );

    hideLoading();

    if (response.isSuccess) {
      Get.to(
        () => SuccessDialog(
          title: 'Successfully verified code!'.tr,
          message: 'You have successfully completed the transaction.'.tr,
          code:
              'Old balance: ${response.responseJson['shop']['balance']}\$\nNew balance: ${response.responseJson['shop']['new_balance']}\$',
        ),
      );
    } else {
      showToast('Failed to verify code.');
    }
  }

  // void onSubmit() async {
  //   if (authenticationType == "NFC") {
  //     writeNFC();
  //   } else {
  //     generateAuthCode();
  //   }
  // }

  void updateChangeType(String type) {
    changeType = type;
    update();
  }
}
