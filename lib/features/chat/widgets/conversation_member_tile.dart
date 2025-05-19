import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/widgets/user_avatar.dart';

class ConversationMemberTile extends StatelessWidget {
  final bool isUser;
  final bool isAdmin;

  const ConversationMemberTile({
    super.key,
    required this.isAdmin,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.h(24)),
      child: Row(
        children: [
          UserAvatar(
            imageUrl:
                'https://i.pinimg.com/736x/b8/cf/9d/b8cf9df60521dc12adf63d0e9b7591af.jpg',
            size: 40,
          ),

          context.sbW(16),

          AppText(
            "Adina Nurrahma",
            style: TextStyle(
              fontSize: context.sp(14),
              color: AppColors.black800,
            ),
          ),

          Spacer(),
          if (isUser)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(8.0)),
              child: AppText(
                "You",
                style: TextStyle(
                  fontSize: context.sp(12),
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey600,
                ),
              ),
            )
          else if (isAdmin)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.w(8),
                vertical: context.h(4),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.blue800,
                borderRadius: BorderRadius.circular(context.r(8)),
              ),
              child: AppText(
                "Admin",
                style: TextStyle(
                  fontSize: context.sp(12),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
