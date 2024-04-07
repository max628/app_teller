import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/theme/theme_colors.dart';

class Loading extends StatelessWidget {
  final bool isLoading;
  final Color backgroundColor;
  final Color color;
  final String? text;

  const Loading({
    super.key,
    this.isLoading = false,
    this.backgroundColor = Colors.white,
    this.color = ThemeColors.accentColor,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor.withOpacity(0.8),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: color,
        ),
      ),
    );
  }
}
