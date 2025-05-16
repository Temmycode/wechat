import 'package:shared_preferences/shared_preferences.dart';

class PrefrenceManager {
  static late final SharedPreferences _prefs;

  static void setAccessToken(String value) {
    _prefs.setString('access_token', value);
  }

  static String? getAccessToken() {
    return _prefs.getString('access_token');
  }

  static void setRefreshToken(String value) {
    _prefs.setString('refresh_token', value);
  }

  static String? getRefreshToken() {
    return _prefs.getString('refresh_token');
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
