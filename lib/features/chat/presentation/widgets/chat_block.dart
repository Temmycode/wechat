import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/formatter.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/presentation/widgets/user_avatar.dart';

class ChatBlock extends StatelessWidget {
  final bool isUser;
  final String message;

  const ChatBlock({super.key, required this.isUser, required this.message});

  @override
  Widget build(BuildContext context) {
    final date = DateFormatter.format(DateTime.now());
    return SizedBox(
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children:
            isUser
                ? [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w(10),
                      vertical: context.h(8),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.r(8)),
                        topRight: Radius.circular(context.r(8)),
                        bottomLeft: Radius.circular(context.r(8)),
                      ),
                      color: AppColors.blue800,
                    ),
                    child: Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: context.w(262)),
                          child: AppText(
                            message,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        AppText(
                          date,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  context.sbW(8),
                  UserAvatar(imageUrl: 'imageUrl', size: 40),
                ]
                : [
                  UserAvatar(imageUrl: 'imageUrl', size: 40),
                  context.sbW(8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.r(8)),
                        topRight: Radius.circular(context.r(8)),
                        bottomRight: Radius.circular(context.r(8)),
                      ),
                      color: AppColors.offWhite2,
                    ),
                  ),
                ],
      ),
    );
  }
}
