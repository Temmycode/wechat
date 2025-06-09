import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/equatable_date_time.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/prefrence_manager.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/features/auth/controllers/providers/auth_notifier_provider.dart';
import 'package:wechat/features/chat/controller/providers/conversation_message_provider.dart';
import 'package:wechat/features/chat/models/conversation.dart';
import 'package:wechat/features/chat/models/message.dart';
import 'package:wechat/features/chat/widgets/chat_app_bar.dart';
import 'package:wechat/features/chat/widgets/chat_block.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final ConversationModel? conversation;
  static const String routeName = "/conversation/chat";

  const ChatScreen({super.key, this.conversation});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  int lastSentMessageId = 1;
  late final TextEditingController _messageController;
  late ConversationModel _conversation;
  late WebSocketChannel _webSocketChannel;

  @override
  void initState() {
    super.initState();
    _conversation = widget.conversation!;
    _messageController = TextEditingController();

    _initializeWebsocket();
  }

  void _initializeWebsocket() async {
    final token = PreferenceManager.getAccessToken();
    final wsUrl = Uri.parse(
      'ws://localhost:8000/ws/${_conversation.id}?token=$token',
    );
    _webSocketChannel = WebSocketChannel.connect(wsUrl);

    await _webSocketChannel.ready;

    _webSocketChannel.stream.listen(
      (message) {
        // TODO: save the message to cache
      },
      onError: (error) {
        throw Exception(error);
      },
      onDone: () {
        debugPrint("Websocket closed");
      },
    );
  }

  void _sendMessage(String content) {
    final currentUser = ref.read(authNotifierProvider).user!;
    final messageNotifier = ref.read(
      conversationMessageNotifier(_conversation.id!).notifier,
    );

    // Create a message so because we can't rely on the message being sent
    // this is because of latency
    final message = MessageModel(
      id: lastSentMessageId,
      senderId: currentUser.id!,
      conversationId: _conversation.id!,
      content: content.trim(),
      timestamp: EquatableDateTime.fromDateTime(DateTime.now()),
      sender: currentUser,
    );

    // Add the created message to the list of existing messages
    messageNotifier.addMessage(message);

    // Now send the message through our websocket channel
    _webSocketChannel.sink.add(jsonEncode({"content": content.trim()}));
    // clear the controller
    _messageController.clear();
  }

  void _setLastSentMessageId(int id) {
    lastSentMessageId = id;
  }

  String get _conversationDisplayPicture {
    final currentUser = ref.read(authNotifierProvider).user;

    if (_conversation.isGroup!) {
      return '';
    } else {
      final userOfDM = _conversation.conversationMembers!.firstWhere(
        (member) => member!.id != currentUser!.id!,
      );

      return userOfDM!.imageUrl ?? '';
    }
  }

  String get _conversationDisplayName {
    if (_conversation.isGroup!) {
      return _conversation.name!;
    }
    final currentMember = ref.read(authNotifierProvider).user;
    final otherMember =
        _conversation.conversationMembers!
            .where((member) => member!.id != currentMember!.id)
            .first;

    return '${otherMember!.firstName} ${otherMember.lastName}';
  }

  @override
  Widget build(BuildContext context) {
    // get the current user
    final currentUser = ref.watch(authNotifierProvider).user;
    print("Current user is $currentUser");
    final conversationMessages = ref.watch(
      conversationMessageNotifier(_conversation.id!),
    );

    return Scaffold(
      backgroundColor: AppColors.offWhite,

      appBar: ChatAppBar(
        height: context.h(73),
        imageUrl: _conversationDisplayPicture,
        name: _conversationDisplayName,
      ),
      body: Stack(
        children: [
          Positioned(
            child: conversationMessages.when(
              data: (messages) {
                // get the last sent messages id
                final id = messages.isEmpty ? 1 : messages.last.id;
                _setLastSentMessageId(id);

                // display a text if there are no messages yet
                if (messages.isEmpty) {
                  return Text("No messages yet").center();
                }

                // display the chat block widget if there are messages
                return ListView.builder(
                  padding: EdgeInsets.only(
                    top: context.h(23),
                    left: context.w(16),
                    right: context.w(16),
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];

                    return ChatBlock(
                      isUser: message.senderId == currentUser?.id!,
                      message: message.content,
                    );
                  },
                );
              },
              error: (stk, err) => Text("An error occurred: $err"),
              loading: () => CircularProgressIndicator(),
            ),
          ),
          Container(
            height: context.h(86),
            padding: EdgeInsets.all(context.w(16)),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.grey100)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Emoji select screen
                AppButton(
                  onPressed: () {},
                  child: AppIcons.emoji.toSvg(
                    height: context.h(24),
                    width: context.h(24),
                  ),
                ),
                context.sbW(16),

                // Text Area
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (content) {
                      // check if the message is not empty
                      // we don't want to be sending back empty messages
                      if (content.isNotEmpty) {
                        _sendMessage(content);
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write a message",
                      hintStyle: GoogleFonts.plusJakartaSans(
                        fontSize: context.sp(12),
                        color: AppColors.grey300,
                      ),
                    ),
                  ),
                ),

                // Add a file
                AppButton(
                  onPressed: () {},
                  child: AppIcons.attach.toSvg(
                    height: context.h(24),
                    width: context.h(24),
                  ),
                ),

                context.sbW(16),

                // Record Voice Note
                AppButton(
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.all(context.sp(8)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue800,
                    ),
                    child: AppIcons.voiceNote.toSvg(
                      height: context.h(24),
                      width: context.h(24),
                    ),
                  ),
                ),
              ],
            ),
          ).bottom(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _webSocketChannel.sink.close();
    super.dispose();
  }
}
