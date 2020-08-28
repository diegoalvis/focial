import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
    } catch (err) {
      throw err;
    }
  }

  static String getString(String key) {
    return _sharedPreferences.getString(key) ?? null;
  }

  static Future<bool> putString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }
}
