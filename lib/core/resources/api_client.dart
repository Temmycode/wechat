import 'package:dio/dio.dart';
import 'package:wechat/core/resources/auth_interceptor.dart';
import 'package:wechat/core/resources/token_manager.dart';

class ApiClient {
  late final Dio dio;
  late final TokenManager tokenManager;

  ApiClient() {
    dio = Dio(
      BaseOptions(baseUrl: 'localhost:8000', contentType: 'application/json'),
    );

    tokenManager = TokenManager(dio: dio);

    dio.interceptors.add(AuthInterceptor(tokenManager: tokenManager, dio: dio));
  }
}
