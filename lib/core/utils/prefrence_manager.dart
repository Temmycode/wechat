import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat/features/auth/models/user.dart';

class PreferenceManager {
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

  static void setUser(String user) {
    _prefs.setString("user", user);
  }

  static UserModel? getUser() {
    final cachedUser = _prefs.getString("user");
    if (cachedUser == null) {
      return null;
    }
    return UserModel.fromJson(cachedUser);
  }
}
