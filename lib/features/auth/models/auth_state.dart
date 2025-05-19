import 'package:equatable/equatable.dart';
import 'package:wechat/features/auth/models/user.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final String? token;
  final UserModel? user;
  final String? error;

  const AuthState({
    required this.isLoading,
    required this.token,
    required this.user,
    required this.error,
  });

  const AuthState.unknown()
    : isLoading = false,
      token = null,
      user = null,
      error = null;

  AuthState copy({
    bool? isLoading,
    String? token,
    UserModel? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, token, user, error];
}
