import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/features/auth/models/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiClient _apiClient = ApiClient();
  AuthNotifier() : super(AuthState.unknown());

  Future<void> login({required String email, required String password}) async {
    final response = await _apiClient.login(email, password);

    // if ()
  }
}
