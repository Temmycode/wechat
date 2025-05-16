import 'package:dio/dio.dart';
import 'package:wechat/core/resources/token_manager.dart';

class AuthInterceptor extends Interceptor {
  final TokenManager tokenManager;
  final Dio dio;
  bool _isRefreshing = false;

  AuthInterceptor({required this.tokenManager, required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    final token = tokenManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);

    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final refreshed = await tokenManager.refreshTokens();

        if (refreshed) {
          // Retry the failed request
          final token = tokenManager.getAccessToken();
          err.requestOptions.headers['Authorization'] = 'Bearer $token';
          final response = await dio.fetch(err.requestOptions);
          _isRefreshing = false;
          return handler.resolve(response);
        }
      } catch (err) {
        _isRefreshing = false;
        // TODO: Navigate to login screen or handle error
      }
    }
  }
}
