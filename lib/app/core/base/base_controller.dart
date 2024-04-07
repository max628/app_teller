import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

import '/theme/theme_colors.dart';
import '/app/core/network/dio_client.dart';
import '/app/models/response_model.dart';
import 'page_state.dart';

abstract class BaseController extends GetxController with DioClient {
  final logoutController = false.obs;

  //Reload the page
  final _refreshController = false.obs;

  setPageRefresh(bool refresh) => _refreshController(refresh);

  //Controls page state
  final _pageSateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageSateController.value;

  updatePageState(PageState state) => _pageSateController(state);

  resetPageState() => _pageSateController(PageState.DEFAULT);

  showLoading() => updatePageState(PageState.LOADING);

  hideLoading() => resetPageState();

  final _messageController = ''.obs;

  String get message => _messageController.value;

  showMessage(String msg) => _messageController(msg);

  final _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;

  showErrorMessage(String msg) {
    _errorMessageController(msg);
  }

  final _successMessageController = ''.obs;

  String get successMessage => _messageController.value;

  showSuccessMessage(String msg) => _successMessageController(msg);

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      textColor: ThemeColors.bodyTextColor,
      backgroundColor: ThemeColors.backgroundColor,
      timeInSecForIosWeb: 1,
    );
  }

  // callDataService<T>(
  //   Future<ResponseModel> future, {
  //   Function(Exception e)? onError,
  //   Function(ResponseModel response)? onSuccess,
  //   Function? onStart,
  //   Function? onComplete,
  // }) async {
  //   Exception? exception;

  //   onStart == null ? showLoading() : onStart();

  //   try {
  //     final ResponseModel response = await future;

  //     if (onSuccess != null) onSuccess(response);

  //     onComplete == null ? hideLoading() : onComplete();

  //     return response;
  //   } on ServiceUnavailableException catch (e) {
  //     exception = e;
  //     showErrorMessage(e.message);
  //   } on UnauthorizedException catch (e) {
  //     exception = e;
  //     showErrorMessage(e.message);
  //   } on TimeoutException catch (e) {
  //     exception = e;
  //     showErrorMessage(e.message ?? 'Timeout exception');
  //   } on NetworkException catch (e) {
  //     exception = e;
  //     showErrorMessage(e.message);
  //   } on JsonFormatException catch (e) {
  //     exception = e;
  //     showErrorMessage(e.message);
  //   } on NotFoundException catch (e) {
  //     exception = e;
  //     showErrorMessage(e.message);
  //   } on ApiException catch (e) {
  //     exception = e;
  //   } on AppException catch (e) {
  //     exception = e;
  //     showErrorMessage(e.message);
  //   } catch (error) {
  //     exception = AppException(message: "$error");
  //     Logger().e("Controller>>>>>> error $error");
  //   }

  //   if (onError != null) onError(exception);

  //   onComplete == null ? hideLoading() : onComplete();
  // }

  @override
  void onClose() {
    _messageController.close();
    _refreshController.close();
    _pageSateController.close();
    super.onClose();
  }
}
