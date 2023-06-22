import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtil {
  static const String login = 'true';
  static getString(String spKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(spKey) ? prefs.getString(spKey) : false;
  }

  static Future setString(String spKey, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(spKey, value);
  }

  static Future remove(
    String spKey,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.remove(spKey);
  }
}
