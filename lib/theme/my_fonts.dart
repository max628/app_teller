import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/app/services/storage_service.dart';
import '/translations/localization_service.dart';

// todo configure text family and size
class MyFonts {
  // return the right font depending on app language
  static TextStyle get getAppFontType =>
      LocalizationService.supportedLanguagesFontsFamilies[StorageService.getCurrentLocal().languageCode]!;

  // title text font
  static TextStyle get titleTextStyle => getAppFontType.copyWith(
        fontSize: 42.sp,
        fontWeight: FontWeight.w700,
        height: 0,
      );

  // body text font
  static TextStyle get bodyTextStyle => getAppFontType.copyWith(
        fontSize: 30.sp,
        fontWeight: FontWeight.w400,
        height: 0,
      );

  // button text font
  static TextStyle get buttonTextStyle => getAppFontType.copyWith(
        color: Colors.black,
        fontSize: buttonTextSize,
        // fontWeight: FontWeight.w700,
        height: 0,
      );

  // list text font
  static TextStyle get listTextStyle => TextStyle(
        fontFamily: 'Ubuntu',
        color: Colors.black,
        fontSize: buttonTextSize,
        fontWeight: FontWeight.w700,
        height: 0,
        letterSpacing: -0.95.sp,
      );

  // app bar text font
  static TextStyle get appBarTextStyle => getAppFontType;

  // chips text font
  static TextStyle get chipTextStyle => getAppFontType;

  // app bar font size
  static double get appBarTittleSize => titleLargeSize;

  // title font size
  static double get titleLargeSize => 48.sp;
  static double get titleMediumSize => 42.sp;
  static double get titleSmallSize => 36.sp;
  // body font size
  static double get bodyLargeSize => 42.sp;
  static double get bodyMediumSize => 30.sp; // default font
  static double get bodySmallTextSize => 20.sp;
  // label font size
  static double get labelLargeSize => bodyMediumSize;
  static double get labelMediumSize => 24.sp;
  static double get labelSmallSize => 20.sp;

  //button font size
  static double get buttonTextSize => 16.sp;

  //chip font size
  static double get chipTextSize => bodyMediumSize;

  // list tile fonts sizes
  static double get listTileTitleSize => buttonTextSize;
  static double get listTileSubtitleSize => 30.sp;
}
