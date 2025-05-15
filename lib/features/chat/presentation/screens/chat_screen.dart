import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/features/chat/presentation/widgets/chat_block.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Stack(
        children: [
          Positioned(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ChatBlock(isUser: true, message: "Hello world");
              },
            ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.grey100)),
              ),
              child: Row(
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
                      decoration: InputDecoration(border: InputBorder.none),
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
            ),
          ),
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
