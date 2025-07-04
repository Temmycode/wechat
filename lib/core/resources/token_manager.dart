import 'package:dio/dio.dart';
import 'package:wechat/core/utils/prefrence_manager.dart';

class TokenManager {
  final Dio dio;
  // final SharedPreferences prefs;

  const TokenManager({required this.dio});

  String? getAccessToken() {
    return PreferenceManager.getAccessToken();
  }

  String? getRefreshToken() {
    return PreferenceManager.getAccessToken();
  }

  void saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    PreferenceManager.setAccessToken(accessToken);
    PreferenceManager.setRefreshToken(refreshToken);
  }

  Future<bool> refreshTokens() async {
    try {
      final refreshToken = getRefreshToken();

      final response = await dio.post(
        '/refresh_token',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        PreferenceManager.setAccessToken(response.data['access_token']);
        return true;
      }

      return false;
    } catch (err) {
      return false;
    }
  }
}
