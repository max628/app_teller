import 'dart:async';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:upgrader/upgrader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/routes/app_pages.dart';
import '/app/services/my_hive.dart';
import '/app/services/storage_service.dart';
import '/theme/my_theme.dart';
import '/translations/localization_service.dart';
import '/constants/config.dart';

///navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

///init app
Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize local db (hive)
  await MyHive.init();
  // Initialize the Isar database.
  // isar = await StorageProvider().initDB(null, inspector: kDebugMode);

  // init shared preference
  await StorageService.init();

  if (kDebugMode || Config.appFlavor.name == Flavor.admin) {
    await Upgrader.clearSavedSettings();
  } else {}

  AdaptiveDialog.instance.updateConfiguration(defaultStyle: AdaptiveStyle.iOS);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool themeIsLight = StorageService.getThemeIsLight();
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      fontSizeResolver: (fontSize, instance) => FontSizeResolvers.radius(fontSize, instance),
      builder: (context, widget) {
        return GetMaterialApp(
          title: "Changepayer App",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          // builder: (context, widget) {
          //   return MediaQuery(
          //     data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.sp)),
          //     child: widget!,
          //   );
          // },
          themeMode: themeIsLight ? ThemeMode.light : ThemeMode.dark,
          theme: MyTheme.getThemeData(isLight: true),
          darkTheme: MyTheme.getThemeData(isLight: false),
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 500),
          locale: StorageService.getCurrentLocal(),
          translations: LocalizationService.getInstance(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
