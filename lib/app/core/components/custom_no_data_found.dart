import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:lottie/lottie.dart';
import 'package:changepayer_app/constants/my_images.dart';
import 'package:changepayer_app/translations/strings_enum.dart';

class NoDataOrInternetScreen extends StatefulWidget {
  final String message;
  final double paddingTop;
  final double imageHeight;
  final bool fromReview;
  final bool isNoInternet;
  final String message2;
  final String image;
  final VoidCallback? onChanged;

  const NoDataOrInternetScreen({
    super.key,
    this.message = Strings.noDataFound,
    this.paddingTop = 6,
    this.imageHeight = .5,
    this.fromReview = false,
    this.isNoInternet = false,
    this.message2 = Strings.noDataFoundDes,
    this.image = MyImages.noInternetImage,
    this.onChanged,
  });
  @override
  State<NoDataOrInternetScreen> createState() => _NoDataOrInternetScreenState();
}

class _NoDataOrInternetScreenState extends State<NoDataOrInternetScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        // if (!widget.isNoInternet) {
        //   Get.offAndToNamed(RouteHelper.loginScreen);
        // }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: mediaSize.height * widget.imageHeight,
                width: widget.isNoInternet ? mediaSize.width * .6 : mediaSize.width * .4,
                child: widget.isNoInternet
                    ? Lottie.asset(
                        MyImages.noInternetImage,
                        height: mediaSize.height * widget.imageHeight,
                        width: mediaSize.width * .6,
                      )
                    : SvgPicture.asset(
                        widget.image,
                        height: 100,
                        width: 100,
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    children: [
                      AutoSizeText(
                        widget.isNoInternet ? Strings.noInternetConnection.tr : widget.message.tr,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: widget.isNoInternet
                              ? context.theme.colorScheme.error
                              : context.theme.colorScheme.onSurface,
                        ),
                        minFontSize: 24,
                        maxFontSize: 48,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        visible: !widget.isNoInternet,
                        child: Text(
                          widget.message2.tr,
                          style: context.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Visibility(
                        visible: !widget.isNoInternet,
                        child: const SizedBox(
                          height: 15,
                        ),
                      ),
                      Visibility(
                        visible: widget.isNoInternet,
                        child: ElevatedButton(
                          onPressed: () async {
                            // final connectivityResult = await Connectivity().checkConnectivity();
                            // if (!connectivityResult.contains(ConnectivityResult.none)) {
                            if (widget.onChanged != null) {
                              widget.onChanged!();
                            } else {
                              Get.back();
                            }
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            backgroundColor: context.theme.colorScheme.error,
                            shadowColor: Colors.transparent,
                          ),
                          child: AutoSizeText(
                            "retry".tr.toUpperCase(),
                            minFontSize: 24.sp,
                            maxFontSize: 48.sp,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
