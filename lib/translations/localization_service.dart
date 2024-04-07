import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/app/services/storage_service.dart';
import 'en_US/en_us_translation.dart';

class LocalizationService extends Translations {
  // prevent creating instance
  LocalizationService._();

  static LocalizationService? _instance;

  static LocalizationService getInstance() {
    _instance ??= LocalizationService._();
    return _instance!;
  }

  // default language
  // todo change the default language
  static Locale defaultLanguage = supportedLanguages[0];

  // supported languages
  static List<Locale> supportedLanguages = const [
    Locale('en', 'GB'),
    Locale('pt', 'PT'),
  ];

  // supported languages fonts family (must be in assets & pubspec yaml) or you can use google fonts
  static Map<String, TextStyle> supportedLanguagesFontsFamilies = {
    // todo add your English font families (add to assets/fonts, pubspec and name it here) default is poppins for english and cairo for arabic
    'en': const TextStyle(fontFamily: 'SegoeUI'),
    'pt': const TextStyle(fontFamily: 'SegoeUI'),
  };

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
      };

  /// check if the language is supported
  static isLanguageSupported(Locale locale) =>
      supportedLanguages.contains(Locale(locale.languageCode, locale.countryCode));

  /// update app language by code language for example (en,ar..etc)
  static updateLanguage(Locale locale) async {
    // check if the language is supported
    if (!isLanguageSupported(locale)) return;
    // update current language in shared pref
    await StorageService.setCurrentLanguage(locale);
    Get.updateLocale(locale);
  }

  /// check if the language is english
  static bool isItEnglish() => StorageService.getCurrentLocal().languageCode.toLowerCase().contains('en');

  /// get current locale
  static Locale getCurrentLocal() => StorageService.getCurrentLocal();

  /// get local Date Format
  static DateFormat dateFormat() => DateFormat.yMd(StorageService.getCurrentLocal().toString());

  /// get Language name from local
  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'uk':
        return "English";
      case 'pt':
        return 'Português';
      // Add more cases for other countries if needed
      default:
        return 'English';
    }
  }
}
