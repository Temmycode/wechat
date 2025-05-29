import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/features/chat/controller/notifiers/conversation_message_notifier.dart';
import 'package:wechat/features/chat/models/message.dart';

final conversationMessageNotifier = AsyncNotifierProvider.autoDispose
    .family<ConversationMessageNotifier, List<MessageModel>, int>(
      ConversationMessageNotifier.new,
    );
