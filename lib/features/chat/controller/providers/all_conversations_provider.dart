import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/features/chat/controller/notifiers/all_conversation_notifier.dart';
import 'package:wechat/features/chat/models/conversation.dart';

final allConversationsProvider =
    AsyncNotifierProvider<AllConversationNotifier, List<ConversationModel>>(
      AllConversationNotifier.new,
    );
