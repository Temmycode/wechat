import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/features/chat/models/message.dart';

class ConversationMessageNotifier
    extends FamilyAsyncNotifier<List<MessageModel>, int> {
  final ApiClient _apiClient = ApiClient();

  Future<List<MessageModel>> loadConversationPreviousMessages(
    int messageId,
  ) async {
    try {
      final response = await _apiClient.loadConversationPreviousMessages(
        messageId,
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        final messages =
            data.map((message) => MessageModel.fromMap(message)).toList();
        return messages;
      } else {
        return [];
      }
    } catch (err) {
      debugPrint(err.toString());
      return [];
    }
  }

  Future<List<MessageModel>> getConversationMessages(int messageId) async {
    // load messages from the remote database
    debugPrint("we are going throught this");
    final messages = await loadConversationPreviousMessages(messageId);
    debugPrint(messages.length.toString());
    // load messages from the cache

    return messages;
  }

  @override
  Future<List<MessageModel>> build(int messageId) async {
    state = const AsyncValue.loading();
    try {
      final messages = getConversationMessages(messageId);
      return messages;
    } catch (err) {
      debugPrint(err.toString());
      state = AsyncValue.error(err, StackTrace.current);
      return [];
    }
  }

  void addMessage(MessageModel message) {
    state = AsyncValue.data([...state.value ?? [], message]);
  }
}
