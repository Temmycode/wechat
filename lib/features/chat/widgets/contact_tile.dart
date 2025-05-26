import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/chat/widgets/user_avatar.dart';

class ContactTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onPressed;

  const ContactTile({super.key, required this.user, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: context.h(10)),
        padding: EdgeInsets.symmetric(horizontal: context.w(16)),
        child: Row(
          children: [
            user.imageUrl == null
                ? UserAvatar(
                  size: 36,
                  withBanner: false,
                  isNetwork: false,
                  backgroundColor: AppColors.blue200,
                )
                : UserAvatar(
                  imageUrl: user.imageUrl,
                  size: 36,
                  withBanner: false,
                ),

            context.sbW(16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.w500,
                    color: AppColors.black800,
                  ),
                ),
                AppText(
                  user.mantra ?? '---',
                  style: TextStyle(
                    fontSize: context.sp(12),
                    color: AppColors.grey600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
