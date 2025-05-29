import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/core/utils/app_navigator.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/chat/controller/providers/all_conversations_provider.dart';
import 'package:wechat/features/chat/models/chat_state.dart';
import 'package:wechat/features/chat/models/conversation.dart';
import 'package:wechat/features/chat/screens/chat_screen.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref ref;
  final ApiClient _apiClient;

  ChatNotifier(this._apiClient, this.ref) : super(ChatState.unknown());

  Future<void> startConverstaion({required UserModel user}) async {
    state = state.copyWith(isLoading: true);

    try {
      final data = {'user_id': user.id!, 'username': user.username!};
      final response = await _apiClient.startConversation(data);

      if (response.statusCode == 201) {
        // replace previous screen with chat screen

        final decodedConversation = ConversationModel.fromJson(response.data);

        // Add the new conversation to the all conversations provider to update it
        ref
            .read(allConversationsProvider.notifier)
            .adddConversation(decodedConversation);

        AppNavigator.instance.navigatePageReplacementWithTransition(
          route: ChatScreen(conversation: decodedConversation),
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
