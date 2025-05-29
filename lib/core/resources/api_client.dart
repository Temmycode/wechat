import 'package:dio/dio.dart';
import 'package:wechat/core/resources/auth_interceptor.dart';
import 'package:wechat/core/resources/token_manager.dart';

class ApiClient {
  late final Dio dio;
  late final TokenManager tokenManager;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8000',
        contentType: 'application/json',
        validateStatus: (status) => status! < 500,
      ),
    );

    tokenManager = TokenManager(dio: dio);

    // Add interceptor after initialization
    dio.interceptors.clear();
    dio.interceptors.add(AuthInterceptor(tokenManager: tokenManager, dio: dio));
  }

  Future<Response> login(FormData data) async {
    return await dio.post('/login', data: data);
  }

  Future<Response> register(Map<String, dynamic> data) async {
    return await dio.post('/register', data: data);
  }

  Future<Response> updateUserProfile(Map<String, dynamic> data) async {
    return await dio.post('/user/update', data: data);
  }

  Future<Response> updateUserProfilePicture(Map<String, dynamic> data) async {
    return await dio.post('/register', data: data);
  }

  Future<Response> getAllConversations() async {
    return await dio.get('/conversation');
  }

  Future<Response> startConversation(Map<String, dynamic> data) async {
    return await dio.post('/conversation/', data: data);
  }

  Future<Response> getAllContactsAsWechatUsers(data) async {
    return await dio.post('/conversation/users', data: data);
  }

  Future<Response> loadConversationPreviousMessages(
    int conversationId, {
    int? since,
    int? limit,
  }) async {
    return await dio.get('/conversation/$conversationId/messages');
  }
}
