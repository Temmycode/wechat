import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:wechat/features/chat/models/message.dart';

class DatabaseService {
  final _box = Hive.box('mybox');

  void addMessageToCache(MessageModel message) {
    var allMessagesinConversation = getAllMessage();
    allMessagesinConversation.add(message);
    print(allMessagesinConversation);
    _box.put('MESSAGES', allMessagesinConversation);
  }

  void addMessagesToCache(List<MessageModel> messages) {
    var allMessagesinConversation = getAllMessage();
    allMessagesinConversation.addAll(messages);
    print(allMessagesinConversation);
    _box.put('MESSAGES', allMessagesinConversation);
  }

  List<MessageModel> getAllMessage() {
    final encodedMessages = _box.get('MESSAGES');
    final List messages = jsonDecode(encodedMessages);
    return messages.map((message) => MessageModel.fromMap(message)).toList();
  }

  List<MessageModel> getMessagesByConversationId(int conversationId) {
    return getAllMessage()
        .where((message) => message.conversationId == conversationId)
        .toList();
  }
}
