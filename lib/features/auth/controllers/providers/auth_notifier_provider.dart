import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/features/auth/controllers/notifiers/auth_notifier.dart';
import 'package:wechat/features/auth/models/auth_state.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (_) => AuthNotifier(ApiClient()),
);
