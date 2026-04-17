import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static late SharedPreferences pref;

  static const String onBoardingKey = "onBoarding";

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> cacheOnBoarding() async {
    await pref.setBool(onBoardingKey, true);
  }

  static bool getOnBoarding() {
    return pref.getBool(onBoardingKey) ?? false;
  }

  static Future<void> cacheData(String key, dynamic value) async {
    if (value is String) {
      await pref.setString(key, value);
    } else if (value is int) {
      await pref.setInt(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (value is List<String>) {
      await pref.setStringList(key, value);
    }
  }

  static dynamic getData(String key) {
    return pref.getString(key) ?? "";
  }

  static Future<void> removeData(String key) async {
    await pref.remove(key);
  }

  static Future<void> clearData() async {
    await pref.clear();
  }
}
