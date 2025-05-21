import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/chat/widgets/user_avatar.dart';

class ContactTile extends StatelessWidget {
  final UserModel? user;

  const ContactTile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.h(10)),
      padding: EdgeInsets.symmetric(horizontal: context.w(16)),
      child: Row(
        children: [
          UserAvatar(
            imageUrl:
                'https://nairametrics.com/wp-content/uploads/2022/04/Linda-Ikeji.png',
            size: 36,
            withBanner: false,
          ),

          context.sbW(16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "Abalas",
                style: TextStyle(
                  fontSize: context.sp(14),
                  fontWeight: FontWeight.w500,
                  color: AppColors.black800,
                ),
              ),
              AppText(
                "with God all things are possible",
                style: TextStyle(
                  fontSize: context.sp(12),
                  color: AppColors.grey600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
