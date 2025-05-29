import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/core/utils/app_navigator.dart';
import 'package:wechat/core/utils/prefrence_manager.dart';
import 'package:wechat/features/auth/models/auth_state.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/auth/views/login_screen.dart';
import 'package:wechat/features/home/presentation/screens/home_screen.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiClient _apiClient;

  AuthNotifier(this._apiClient) : super(AuthState.unknown()) {
    state = state.copy(
      token: PreferenceManager.getAccessToken(),
      user: PreferenceManager.getUser(),
    );
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copy(isLoading: true, error: null);
    try {
      final jsonData = FormData.fromMap({
        'username': email,
        'password': password,
      });
      final response = await _apiClient.login(jsonData);

      final data = response.data;

      if (response.statusCode == 200) {
        AppNavigator.instance.navigateToPage(routeName: HomeScreen.routeName);
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        final user = UserModel.fromMap(data['user']).toJson();
        debugPrint(user.toString());

        PreferenceManager.setAccessToken(accessToken);
        PreferenceManager.setRefreshToken(refreshToken);
        PreferenceManager.setUser(user);
        state = state.copy(isLoading: false, token: accessToken, error: null);
      } else {
        final errorMessage = data['message'] ?? 'An error occurred';
        state = state.copy(isLoading: false, error: errorMessage);
      }
    } catch (err) {
      debugPrint(err.toString());
      state = state.copy(
        isLoading: false,
        error: 'Unable to connect to server. Please try again.',
      );
    }
  }

  Future<void> register({required UserModel user}) async {
    state = state.copy(isLoading: true, error: null);
    try {
      final response = await _apiClient.register(user.createUser());
      final data = response.data;

      if (response.statusCode == 201) {
        AppNavigator.instance.pushAndRemoveUnitlWithTransition(
          route: LoginScreen(),
        );
      } else {
        final errorMessage =
            data['message'] ?? 'An error occurred during registration';
        state = state.copy(isLoading: false, error: errorMessage);
      }
    } catch (err) {
      debugPrint(err.toString());
      state = state.copy(
        isLoading: false,
        error: 'Unable to connect to server. Please try again.',
      );
    }
  }
}
