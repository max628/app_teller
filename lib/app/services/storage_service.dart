import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/translations/localization_service.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();

  // get secure storage
  static late FlutterSecureStorage _storage;
  // get storage
  static late SharedPreferences _prefs;

  // STORING KEYS
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _tokenExpirationKey = 'tokenExpiration';

  static const String _fcmTokenKey = 'fcm_token';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';

  /// save/get generated access token
  static Future setAccessToken(String token) async {
    await _storage.write(
      key: _accessTokenKey,
      value: token,
    );
  }

  static Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);

  /// save/get generated refresh token
  static Future setRefreshToken(String token) async {
    await _storage.write(
      key: _refreshTokenKey,
      value: token,
    );
  }

  static Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  /// save/get generated token expiration
  static Future setTokenExpiration(String token) async {
    await _storage.write(
      key: _tokenExpirationKey,
      value: token,
    );
  }

  static Future<String?> getTokenExpiration() => _storage.read(key: _tokenExpirationKey);

  /// save/get generated token expiration
  static Future clearSecureStorage() => _storage.deleteAll();

  /// init get storage services
  static Future<void> init() async {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    _prefs = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _prefs = sharedPreferences;
  }

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) => _prefs.setBool(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _prefs.getBool(_lightThemeKey) ?? true; // TODO set the default theme (true for light, false for dark)

  /// save current locale
  static Future<void> setCurrentLanguage(Locale locale) =>
      _prefs.setStringList(_currentLocalKey, [
        locale.languageCode,
        locale.countryCode ?? '',
      ]);

  /// get current locale
  static Locale getCurrentLocal() {
    List localeKey = _prefs.getStringList(_currentLocalKey) ?? [];
    if (localeKey.isNotEmpty) {
      return Locale(localeKey[0], localeKey[1]);
    }
    return LocalizationService.defaultLanguage;
  }

  /// save/get generated fcm token
  static Future<void> setFcmToken(String token) => _prefs.setString(_fcmTokenKey, token);
  static String? getFcmToken() => _prefs.getString(_fcmTokenKey);

  static String? getString(String key) => _prefs.getString(key);
  static Future<bool> setString(String key, String value) => _prefs.setString(key, value);
  static int? getInt(String key) => _prefs.getInt(key);
  static Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);
  static double? getDouble(String key) => _prefs.getDouble(key);
  static Future<bool> setDouble(String key, double value) => _prefs.setDouble(key, value);
  static bool? getBool(String key) => _prefs.getBool(key);
  static Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  static List<String>? getStringList(String key) => _prefs.getStringList(key);
  static Future<bool> setStringList(String key, List<String> value) => _prefs.setStringList(key, value);
  static Future<bool> remove(String key) => _prefs.remove(key);

  /// clear all data from shared pref
  static Future<void> clear() async => await _prefs.clear();
}
