import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'theme_colors.dart';
import 'my_styles.dart';

import '/app/services/storage_service.dart';

class MyTheme {
  static getThemeData({required bool isLight}) {
    return ThemeData(
      // main color (app bar,tabs..etc)
      primaryColor: ThemeColors.primaryColor,

      // secondary & background color
      // colorScheme: ColorScheme.fromSeed(
      //   seedColor: ThemeColors.primaryColor,
      //   background: ThemeColors.accentColor,
      //   brightness: isLight ? Brightness.light : Brightness.dark,
      // ).copyWith(
      //   primary: ThemeColors.primaryColor,
      //   secondary: ThemeColors.accentColor,
      //   tertiary: ThemeColors.ronTurquoise,
      //   error: ThemeColors.medicalBgColor,
      // ),

      // color contrast (if the theme is dark text should be white for example)
      brightness: isLight ? Brightness.light : Brightness.dark,

      // card widget background color
      cardColor: ThemeColors.cardColor,

      // hint text color
      hintColor: ThemeColors.hintTextColor,

      // divider color
      dividerColor: ThemeColors.dividerColor,

      // app background color
      scaffoldBackgroundColor: ThemeColors.scaffoldBackgroundColor,

      // progress bar theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeColors.primaryColor,
      ),

      // appBar theme
      appBarTheme: MyStyles.getAppBarTheme(isLight),

      // button theme
      textButtonTheme: MyStyles.getTextButtonTheme(isLight),
      elevatedButtonTheme: MyStyles.getElevatedButtonTheme(isLight),
      outlinedButtonTheme: MyStyles.getOutlinedButtonTheme(isLight),

      // text theme
      textTheme: MyStyles.getTextTheme(isLight),

      // chip theme
      chipTheme: MyStyles.getChipTheme(isLight),

      // icon theme
      iconTheme: MyStyles.getIconTheme(isLight),

      // list tile theme
      listTileTheme: MyStyles.getListTileThemeData(isLight),
      switchTheme: MyStyles.getSwitchThemeData(isLight),

      checkboxTheme: MyStyles.getCheckboxThemeData(isLight),

      bottomNavigationBarTheme: MyStyles.getBottomNavigationBarTheme(isLight),

      inputDecorationTheme: MyStyles.getInputDecorationTheme(isLight),

      dividerTheme: const DividerThemeData(
        color: ThemeColors.dividerColor,
        thickness: 0.52,
        // space: 0,
      ),

      datePickerTheme: MyStyles.getDatePickerThemeData(isLight),

      cupertinoOverrideTheme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          actionTextStyle: MyStyles.getTextTheme(isLight).bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          primaryColor: Colors.black,
        ),
      ),

    );
  }

  /// update app theme and save theme type to shared pref
  /// (so when the app is killed and up again theme will remain the same)
  static changeTheme() {
    // *) check if the current theme is light (default is light)
    bool isLightTheme = StorageService.getThemeIsLight();

    // *) store the new theme mode on get storage
    StorageService.setThemeIsLight(!isLightTheme);

    // *) let GetX change theme
    Get.changeThemeMode(!isLightTheme ? ThemeMode.light : ThemeMode.dark);
  }

  /// check if the theme is light or dark
  static bool get getThemeIsLight => StorageService.getThemeIsLight();
}
