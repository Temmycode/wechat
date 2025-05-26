import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/features/auth/controllers/providers/auth_notifier_provider.dart';
import 'package:wechat/features/chat/models/conversation.dart';
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
  late final TextEditingController _messageController;
  late ConversationModel _conversation;

  @override
  void initState() {
    super.initState();
    _conversation = widget.conversation!;
    _messageController = TextEditingController();
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
    return Scaffold(
      backgroundColor: AppColors.offWhite,

      appBar: ChatAppBar(
        height: context.sp(73),
        imageUrl: _conversationDisplayPicture,
        name: _conversationDisplayName,
      ),
      body: Stack(
        children: [
          Positioned(
            child: ListView.builder(
              padding: EdgeInsets.only(
                top: context.h(23),
                left: context.w(16),
                right: context.w(16),
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ChatBlock(isUser: index.isOdd, message: "Hello world");
              },
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
    super.dispose();
  }
}
