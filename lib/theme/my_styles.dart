import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:changepayer_app/theme/theme_extensions/custom_card_color_theme_data.dart';
// import 'package:changepayer_app/theme/theme_extensions/custom_chip_colors.dart';

import 'my_fonts.dart';
import 'theme_colors.dart';

class MyStyles {
  ///icons theme
  static IconThemeData getIconTheme(bool isLightTheme) => const IconThemeData(color: ThemeColors.iconColor);

  ///app bar theme
  static AppBarTheme getAppBarTheme(bool isLightTheme) => AppBarTheme(
        elevation: 0,
        titleTextStyle: getTextTheme(isLightTheme).titleLarge,
        iconTheme: const IconThemeData(color: ThemeColors.appbarIconsColor),
        backgroundColor: ThemeColors.appBarColor,
      );

  ///text theme
  static TextTheme getTextTheme(bool isLightTheme) => TextTheme(
        titleLarge: MyFonts.titleTextStyle.copyWith(
          fontSize: MyFonts.titleLargeSize,
          color: ThemeColors.titleTextColor,
        ),
        titleMedium: MyFonts.titleTextStyle.copyWith(
          fontSize: MyFonts.titleMediumSize,
          color: ThemeColors.titleTextColor,
        ),
        titleSmall: MyFonts.titleTextStyle.copyWith(
          fontSize: MyFonts.titleSmallSize,
          color: ThemeColors.titleTextColor,
        ),
        bodyLarge: MyFonts.bodyTextStyle.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: MyFonts.bodyLargeSize,
          color: ThemeColors.bodyTextColor,
        ),
        bodyMedium: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.bodyMediumSize,
          color: ThemeColors.bodyTextColor,
        ),
        bodySmall: TextStyle(
          color: ThemeColors.bodySmallTextColor.withOpacity(0.5),
          fontSize: MyFonts.bodySmallTextSize,
        ),
        labelLarge: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.labelLargeSize,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.labelMediumSize,
          color: Colors.white,
          decorationColor: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        labelSmall: MyFonts.bodyTextStyle.copyWith(
          fontSize: MyFonts.labelSmallSize,
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w700,
        ),
      );

  static ChipThemeData getChipTheme(bool isLightTheme) {
    return ChipThemeData(
      backgroundColor: ThemeColors.chipBackground,
      brightness: Brightness.light,
      labelStyle: getChipTextStyle(isLightTheme),
      secondaryLabelStyle: getChipTextStyle(isLightTheme),
      selectedColor: Colors.black,
      disabledColor: Colors.green,
      padding: EdgeInsets.all(5.sp),
      secondarySelectedColor: Colors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  ///Chips text style
  static TextStyle getChipTextStyle(bool isLightTheme) {
    return MyFonts.chipTextStyle.copyWith(
      fontSize: MyFonts.chipTextSize,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: -0.95,
    );
  }

  //text button theme data
  static TextButtonThemeData getTextButtonTheme(bool isLight) => TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(9.r),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.all<Size>(Size(326.sp, 56.sp)),
          // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 8.h)),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return MyFonts.buttonTextStyle.copyWith(
                  color: ThemeColors.buttonTextColor,
                );
              } else if (states.contains(MaterialState.disabled)) {
                return MyFonts.buttonTextStyle.copyWith(
                  color: ThemeColors.buttonDisabledTextColor,
                );
              }
              return MyFonts.buttonTextStyle;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return ThemeColors.buttonTextColor;
              } else if (states.contains(MaterialState.disabled)) {
                return ThemeColors.buttonDisabledTextColor;
              }
              return ThemeColors.buttonTextColor; // Use the component's default.
            },
          ),
          // overlayColor: MaterialStateProperty.all<Color>(ThemeColors.buttonColor.withOpacity(0.5)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return ThemeColors.buttonColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return ThemeColors.buttonDisabledColor;
              }
              return ThemeColors.buttonColor; // Use the component's default.
            },
          ),
        ),
      );

  //elevated button theme data
  static ElevatedButtonThemeData getElevatedButtonTheme(bool isLightTheme) => ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.r),
            ),
          ),
          elevation: MaterialStateProperty.all(4.sp),
          minimumSize: MaterialStateProperty.all<Size>(Size(326.sp, 56.sp)),
          // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 8.h)),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return MyFonts.buttonTextStyle.copyWith(
                  color: ThemeColors.buttonTextColor,
                );
              } else if (states.contains(MaterialState.disabled)) {
                return MyFonts.buttonTextStyle.copyWith(
                  color: ThemeColors.buttonDisabledTextColor,
                );
              }
              return MyFonts.buttonTextStyle;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return ThemeColors.buttonTextColor;
              } else if (states.contains(MaterialState.disabled)) {
                return ThemeColors.buttonDisabledTextColor;
              }
              return ThemeColors.buttonTextColor; // Use the component's default.
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return ThemeColors.buttonColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return ThemeColors.buttonDisabledColor;
              }
              return ThemeColors.buttonColor; // Use the component's default.
            },
          ),
        ),
      );

  // outlined button text style
  static MaterialStateProperty<TextStyle?>? getOutlinedButtonTextStyle({
    bool isBold = false,
    double? fontSize,
  }) {
    return MaterialStateProperty.resolveWith<TextStyle>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return MyFonts.buttonTextStyle.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize ?? MyFonts.buttonTextSize,
            color: Colors.white,
          );
        } else if (states.contains(MaterialState.disabled)) {
          return MyFonts.buttonTextStyle.copyWith(
            fontSize: fontSize ?? MyFonts.buttonTextSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: ThemeColors.buttonDisabledTextColor,
          );
        }
        return MyFonts.buttonTextStyle.copyWith(
          fontSize: fontSize ?? MyFonts.buttonTextSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: ThemeColors.buttonColor,
        ); // Use the component's default.
      },
    );
  }

  //outlined button theme data
  static OutlinedButtonThemeData getOutlinedButtonTheme(bool isLightTheme) => OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(),
          ),
          minimumSize: MaterialStateProperty.all<Size>(Size(326.sp, 56.sp)),
          elevation: MaterialStateProperty.all(0),
          // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 8.h)),
          textStyle: getOutlinedButtonTextStyle(),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return ThemeColors.buttonTextColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return ThemeColors.buttonDisabledColor;
              }
              return ThemeColors.buttonTextColor; // Use the component's default.
            },
          ),
        ),
      );

  /// list tile theme data
  static ListTileThemeData getListTileThemeData(bool isLightTheme) {
    return ListTileThemeData(
      // shape: const Border.symmetric(
      //   horizontal: BorderSide(
      //     color: ThemeColors.backgroundColor,
      //     // color: Colors.transparent,
      //     width: 1,
      //   ),
      // ),
      // horizontalTitleGap: 10.r,
      iconColor: ThemeColors.listTileIconColor,
      // contentPadding: EdgeInsets.symmetric(horizontal: 24.sp),
      visualDensity: VisualDensity.compact,
      tileColor: ThemeColors.listTileBackgroundColor,
      titleTextStyle: MyFonts.listTextStyle.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: MyFonts.listTileTitleSize,
        color: ThemeColors.listTileTitleColor,
      ),
      subtitleTextStyle: MyFonts.listTextStyle.copyWith(
        fontSize: MyFonts.listTileSubtitleSize,
        color: ThemeColors.listTileSubtitleColor,
      ),
    );
  }

  /// list tile theme data
  static SwitchThemeData getSwitchThemeData(bool isLightTheme) {
    return SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Colors.white;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return ThemeColors.buttonDisabledColor;
          }
          if (states.contains(MaterialState.selected)) {
            return ThemeColors.primaryColor;
          }
          return ThemeColors.buttonDisabledColor;
        },
      ),
    );
  }

  /// list tile theme data
  static CheckboxThemeData getCheckboxThemeData(bool isLightTheme) {
    return CheckboxThemeData(
      // fillColor: MaterialStateColor.resolveWith((states) {
      //   if (states.contains(MaterialState.selected)) {
      //     return ThemeColors.primaryColor;
      //   }
      //   return ThemeColors.backgroundColor;
      // }),
      // checkColor: MaterialStateProperty.all<Color>(ThemeColors.primaryColor),
      overlayColor: MaterialStateProperty.all<Color>(ThemeColors.primaryColor.withOpacity(0.1)),
      // splashRadius: 16.0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xFFD5D5D5),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(5.87),
      ),
    );
  }

  /// Bottom NavigationBar theme data
  static BottomNavigationBarThemeData getBottomNavigationBarTheme(bool isLightTheme) =>
      const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ThemeColors.appBarColor,
        selectedItemColor: ThemeColors.accentColor,
      );

  static InputDecorationTheme getInputDecorationTheme(bool isLightTheme) => InputDecorationTheme(
        contentPadding: EdgeInsets.all(12.sp),
        // contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
        border: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.hintTextColor, width: 1.sp),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.primaryColor, width: 1.sp),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: ThemeColors.colorScheme.error, width: 1.sp),
        // ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.primaryColor, width: 1.sp),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.hintTextColor, width: 1.sp),
        ),
        isDense: true,
        hintStyle: getTextTheme(isLightTheme).labelMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: ThemeColors.hintTextColor,
            ),
        // labelText: 'Search',
        labelStyle: getTextTheme(isLightTheme).labelMedium,
        filled: true,
        fillColor: ThemeColors.scaffoldBackgroundColor,
        iconColor: ThemeColors.hintTextColor,
        // prefixIcon: const Padding(
        //   padding: EdgeInsets.only(
        //     left: 18,
        //     right: 20,
        //   ),
        //   child: Icon(
        //     Icons.search,
        //     color: ThemeColors.hintColor,
        //   ),
        // ),
        prefixIconColor: ThemeColors.hintTextColor,
        // prefixIconConstraints: BoxConstraints(minWidth: 0, maxHeight: 24.sp),
        // suffixIconConstraints: BoxConstraints(minWidth: 0, maxHeight: 24.sp),
        // errorStyle: getTextTheme(isLightTheme).labelMedium?.copyWith(
        //       color: ThemeColors.colorScheme.error,
        //     ),
      );

  static DatePickerThemeData getDatePickerThemeData(bool isLightTheme) => DatePickerThemeData(
        inputDecorationTheme: getInputDecorationTheme(isLightTheme),
        dayStyle: getTextTheme(isLightTheme).bodyMedium?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
        weekdayStyle: getTextTheme(isLightTheme).bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        yearStyle: getTextTheme(isLightTheme).bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      );
}
