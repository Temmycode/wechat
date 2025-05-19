import 'package:dio/dio.dart';
import 'package:wechat/core/resources/token_manager.dart';

class AuthInterceptor extends Interceptor {
  final TokenManager tokenManager;
  final Dio dio;

  AuthInterceptor({required this.tokenManager, required this.dio});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip token inclusion for login and register
    if (options.path == '/login' || options.path == '/register') {
      return handler.next(options);
    }

    final token = tokenManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final token = await tokenManager.refreshTokens();
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $token';
        final response = await dio.fetch(opts);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
