import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/features/chat/models/conversation.dart';
import 'dart:developer' as dev;

class AllConversationNotifier extends AsyncNotifier<List<ConversationModel>> {
  final ApiClient _apiClient = ApiClient();

  Future<List<ConversationModel>> get allConversations async {
    try {
      final response = await _apiClient.getAllConversations();

      if (response.statusCode == 200) {
        final List encodedConversations = response.data;

        final conversations =
            encodedConversations
                .map((conversation) => ConversationModel.fromJson(conversation))
                .toList();

        debugPrint('$conversations');

        return conversations;
      } else {
        dev.log("Error is ${response.data}");
        return [];
      }
    } catch (err) {
      dev.log("Error is $err");
      debugPrint(err.toString());
      return [];
    }
  }

  @override
  Future<List<ConversationModel>> build() async {
    state = const AsyncValue.loading();
    try {
      final conversations = await allConversations;
      state = AsyncValue.data(conversations);
      return conversations;
    } catch (err) {
      debugPrint(err.toString());
      state = AsyncValue.error(err, StackTrace.current);
      return [];
    }
  }

  Future<void> refreshConversations() async {}

  void adddConversation(ConversationModel conversation) {
    state = AsyncValue.data([conversation, ...state.value ?? []]);
  }
}
