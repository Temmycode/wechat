import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/features/chat/models/chat_state.dart';
import 'package:wechat/features/chat/models/conversation.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final ApiClient _apiClient;

  ChatNotifier(this._apiClient) : super(ChatState.unknown());

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
      }
    } catch (err) {
      state = state.copyWith(isLoading: false, error: err.toString());
    }
  }
}
