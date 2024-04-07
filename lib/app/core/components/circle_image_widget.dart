import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '/constants/my_images.dart';

class CircleImageWidget extends StatelessWidget {
  final double radius;
  final String imagePath;
  final String? title;
  final bool isAsset;
  final bool isBase64;
  final Callback? press;
  final double border;
  final Color? borderColor;

  const CircleImageWidget({
    super.key,
    this.border = 0,
    this.borderColor,
    this.radius = 65,
    this.isAsset = true,
    this.isBase64 = false,
    required this.imagePath,
    this.title,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (radius + border).sp,
      height: (radius + border).sp,
      decoration: BoxDecoration(
        // color: Colors.transparent,
        border: Border.all(
          color: borderColor ?? Theme.of(context).colorScheme.tertiary,
          width: border.sp,
        ),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: isAsset && imagePath.isNotEmpty
            ? isBase64
                ? Image.memory(
                    base64Decode(imagePath),
                    fit: BoxFit.cover,
                    width: radius,
                    height: radius,
                  )
                : Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: radius,
                    height: radius,
                  )
            : FadeInImage.assetNetwork(
                image: imagePath,
                fit: BoxFit.cover,
                width: radius,
                height: radius,
                imageErrorBuilder: (ctx, object, trx) {
                  return Image.asset(
                    MyImages.defaultAvatar,
                    fit: BoxFit.fitHeight,
                    width: radius,
                    height: radius,
                  );
                },
                placeholder: MyImages.defaultAvatar,
              ),
      ),
    );
  }
}
