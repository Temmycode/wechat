import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/extensions.dart';
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
                    margin: EdgeInsets.only(bottom: context.h(isUser ? 8 : 16)),
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
                        ).right(),
                        AppText(
                          date,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ).right(),
                      ],
                    ),
                  ),
                  context.sbW(8),
                  UserAvatar(
                    imageUrl:
                        'https://variety.com/wp-content/uploads/2024/02/GettyImages-1851273250-e1722957713756.jpg?w=1000&h=667&crop=1',
                    size: 40,
                  ),
                ]
                : [
                  UserAvatar(
                    imageUrl:
                        'https://variety.com/wp-content/uploads/2024/02/GettyImages-1851273250-e1722957713756.jpg?w=1000&h=667&crop=1',
                    size: 40,
                  ),
                  context.sbW(8),
                  Container(
                    margin: EdgeInsets.only(bottom: context.h(isUser ? 8 : 16)),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w(10),
                      vertical: context.h(8),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.r(8)),
                        topRight: Radius.circular(context.r(8)),
                        bottomRight: Radius.circular(context.r(8)),
                      ),
                      color: AppColors.offWhite2,
                    ),
                    child: Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: context.w(262)),
                          child: AppText(
                            message,
                            style: TextStyle(
                              color: AppColors.black800,
                              fontSize: 12,
                            ),
                          ),
                        ).right(),
                        AppText(
                          date,
                          style: TextStyle(
                            color: AppColors.black800,
                            fontSize: 12,
                          ),
                        ).right(),
                      ],
                    ),
                  ),
                ],
      ),
    );
  }
}
