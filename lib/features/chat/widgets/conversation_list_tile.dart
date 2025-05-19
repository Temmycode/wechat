import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/formatter.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/screens/chat_screen.dart';
import 'package:wechat/features/chat/widgets/user_avatar.dart';

class ConversationListTile extends StatelessWidget {
  const ConversationListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return AppButton(
      onPressed: () {
        navigator.pushNamed(ChatScreen.routeName);
      },
      child: Container(
        height: context.h(64),
        margin: EdgeInsets.only(
          left: context.w(8),
          right: context.w(8),
          bottom: context.h(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Profile Picture
            Row(
              children: [
                UserAvatar(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRotpIiKE4pEEvHr8JXbz_8s7X63nZF_YpwAzq38erUIhN97xIwJeI8Jv8RlmmKfvhAK6jX-dYvNdTEG8iOY9WtXw',
                ),

                context.sbW(16),

                // User Details
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.h(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        'Darlene Steward',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: context.sp(14),
                          color: AppColors.black800,
                        ),
                      ),
                      AppText(
                        'Pls take a look at the images',
                        style: TextStyle(
                          fontSize: context.sp(12),
                          color: AppColors.grey600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Time message sent & No of unread messages
            Padding(
              padding: EdgeInsets.only(
                top: context.h(10),
                bottom: context.h(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    DateFormatter.format(DateTime.now()),
                    style: TextStyle(
                      fontSize: context.sp(12),
                      color: AppColors.grey600,
                    ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    height: context.h(24),
                    width: context.h(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue800,
                    ),
                    child: AppText(
                      '5',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.sp(12),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
