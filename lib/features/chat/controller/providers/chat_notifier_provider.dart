import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/features/chat/controller/notifiers/chat_notifier.dart';
import 'package:wechat/features/chat/models/chat_state.dart';

final chatNotifierProvider = StateNotifierProvider<ChatNotifier, ChatState>(
  (_) => ChatNotifier(ApiClient()),
);
