import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wechat/core/utils/equatable_date_time.dart';
import 'package:wechat/features/chat/models/message.dart';

class DatabaseService {
  final _box = Hive.box<MessageModel>('MessageBox');

  void addMessageToCache(MessageModel message) {
    try {
      final messageWithEquatableDate = message.copyWith(
        timestamp: EquatableDateTime.fromDateTime(message.timestamp),
      );
      _box.add(messageWithEquatableDate);
    } catch (err) {
      debugPrint("Error adding message to cache: $err");
    }
  }

  void addMessagesToCache(List<MessageModel> messages) {
    var messagesWithEquatableDate = messages.map(
      (message) => message.copyWith(
        timestamp: EquatableDateTime.fromDateTime(message.timestamp),
      ),
    );
    _box.addAll(messagesWithEquatableDate);
  }

  List<MessageModel> getAllMessage() {
    final messages = _box.values.toList();

    return messages;
  }

  List<MessageModel> getMessagesByConversationId(int conversationId) {
    return getAllMessage()
        .where((message) => message.conversationId == conversationId)
        .toList();
  }
}
