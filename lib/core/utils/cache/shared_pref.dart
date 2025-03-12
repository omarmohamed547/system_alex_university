import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefernceUtilis {
  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(String key, dynamic value) async {
    if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is bool) {
      return await prefs.setBool(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      return await prefs.setStringList(key, value);
    }
    return false; // Return false if the value type is unsupported
  }

  static Object? getData(String key) {
    return prefs.get(key);
  }

  static Future<bool> removeData(String key) {
    return prefs.remove(key);
  }
}
