import 'package:dio/dio.dart';
import 'package:wechat/core/resources/auth_interceptor.dart';
import 'package:wechat/core/resources/token_manager.dart';
import 'package:wechat/features/auth/models/user.dart';

class ApiClient {
  late final Dio dio;
  late final TokenManager tokenManager;

  constApiClient() {
    dio = Dio(
      BaseOptions(baseUrl: 'localhost:8000', contentType: 'application/json'),
    );

    tokenManager = TokenManager(dio: dio);

    dio.interceptors.add(AuthInterceptor(tokenManager: tokenManager, dio: dio));
  }

  Future<Response> login(String email, String password) async {
    return await dio.post('/login');
  }

  Future<Response> register(UserModel user) async {
    return await dio.post('/register');
  }
}
