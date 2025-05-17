import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final String? token;
  final String? error;

  const AuthState({
    required this.isLoading,
    required this.token,
    required this.error,
  });

  const AuthState.unknown() : isLoading = false, token = null, error = null;

  AuthState copy({bool? isLoading, String? token, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, token, error];
}
