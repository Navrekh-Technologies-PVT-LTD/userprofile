// Dart imports:
import 'dart:developer';

import 'package:intl/date_symbol_data_local.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:yoursportz/injection/injection.dart';
import 'package:yoursportz/utils/logger.dart';

class AppPrefs {
  final StreamingSharedPreferences preferences;

  AppPrefs(
    this.preferences,
  )   : token = preferences.getString(
          PrefsConstants.token,
          defaultValue: '',
        ),
        name = preferences.getString(
          PrefsConstants.name,
          defaultValue: '',
        ),
        userId = preferences.getString(
          PrefsConstants.userId,
          defaultValue: '',
        ),
        language = preferences.getString(
          PrefsConstants.language,
          defaultValue: '',
        ),
        profileImage = preferences.getString(
          PrefsConstants.profileImage,
          defaultValue: '',
        ),
        phoneNumber = preferences.getString(
          PrefsConstants.phoneNumber,
          defaultValue: '',
        ),
        userName = preferences.getString(
          PrefsConstants.userName,
          defaultValue: '',
        ),
        accountType = preferences.getString(
          PrefsConstants.accountType,
          defaultValue: '',
        ),
        email = preferences.getString(
          PrefsConstants.email,
          defaultValue: '',
        );

  Preference<String> token;
  Preference<String> userId;
  Preference<String> name;
  Preference<String> phoneNumber;
  Preference<String> userName;
  Preference<String> language;
  Preference<String> email;
  Preference<String> profileImage;
  Preference<String> accountType;

  Future<bool> setBool(String key, bool value) async {
    printBefore(value: value, key: key);
    return await preferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    printBefore(value: value, key: key);
    return await preferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    printBefore(value: value, key: key);
    return await preferences.setInt(key, value);
  }

  Future<void> clear() async {
    await preferences.clear();
  }

  Future<bool> setString(String key, String value) async {
    printBefore(value: value, key: key);
    return await preferences.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    printBefore(value: value, key: key);
    return await preferences.setStringList(key, value);
  }

  Future<bool> setCustomValue(
      String key, value, PreferenceAdapter<dynamic> adapter) async {
    printBefore(value: value, key: key);
    return await preferences.setCustomValue(key, value, adapter: adapter);
  }

  void printBefore({String? key, value}) =>
      log('Saving Key: $key &  value: $value');
}

class PrefsConstants {
  static const String token = 'token';
  static const String name = 'name';
  static const String userId = 'userId';
  static const String phoneNumber = 'phoneNumber';
  static const String userName = 'userName';
  static const String language = 'language';
  static const String profileImage = 'profileImage';
  static const String email = 'email';
  static const String accountType = 'accountType';
}

/// Making AppPrefs injectable
Future<void> setupLocator() async {
  initializeDateFormatting();
  final preferences = await StreamingSharedPreferences.instance;
  getIt.registerLazySingleton<AppPrefs>(() => AppPrefs(preferences));
  logger.w("Registering App Router");
  logger.w("Registerd App Router");
}
