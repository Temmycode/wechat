import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/core/utils/contact_helper.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/chat/models/chat_state.dart';
import 'package:wechat/features/chat/models/conversation.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final ApiClient _apiClient;

  ChatNotifier(this._apiClient) : super(ChatState.unknown()) {
    getAllWeChatUsersonContactList();
  }

  Future<void> getAllWeChatUsersonContactList() async {
    try {
      final phoneNumbers = await ContactHelper.getContactPhoneNumbers();
      debugPrint(phoneNumbers.toString());
      final response = await _apiClient.getAllContactsAsWechatUsers(
        phoneNumbers,
      );

      if (response.statusCode == 200) {
        final List<UserModel> users =
            response.data.map((json) => UserModel.fromMap(json)).toList();

        state = state.copyWith(contactUsers: users);
      } else {
        debugPrint(response.data);
        state = state.copyWith(error: response.data.toString());
      }
    } catch (err) {
      debugPrint(err.toString());
      state = state.copyWith(error: err.toString());
    }
  }

  Future<void> getAllConversations() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _apiClient.getAllConversations();

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> encodedConversations = response.data;
        final converstaions =
            encodedConversations
                .map((conversation) => ConversationModel.fromJson(conversation))
                .toList();
        state = state.copyWith(
          isLoading: false,
          allConversations: converstaions,
        );
      } else {
        state = state.copyWith(isLoading: false, error: response.data);
      }
    } catch (err) {
      debugPrint(err.toString());
      state = state.copyWith(isLoading: false, error: err.toString());
    }
  }

  Future<void> startConverstaion({
    required int userId,
    required String username,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final data = {'user_id': userId, 'username': username};
      final response = await _apiClient.startConversation(data);

      if (response.statusCode == 201) {
        final decodedConversation = ConversationModel.fromJson(response.data);
        state = state.copyWith(
          allConversations: [decodedConversation, ...state.allConversations],
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (err) {
      debugPrint(err.toString());
      state = state.copyWith(isLoading: false, error: err.toString());
    }
  }
}
