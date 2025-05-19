import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/formatter.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/widgets/user_avatar.dart';

class CallListTile extends StatelessWidget {
  const CallListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final timeOfCall = DateFormatter.format(DateTime.now());

    return Container(
      height: context.h(64),
      padding: EdgeInsets.only(
        left: context.w(15),
        right: context.w(24),
        bottom: context.h(8),
        top: context.h(8),
      ),
      margin: EdgeInsets.only(bottom: context.h(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Profile picture
              UserAvatar(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRotpIiKE4pEEvHr8JXbz_8s7X63nZF_YpwAzq38erUIhN97xIwJeI8Jv8RlmmKfvhAK6jX-dYvNdTEG8iOY9WtXw',
              ),

              context.sbW(16),

              // User Details
              Column(
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
                  Row(
                    children: [
                      AppIcons.outgoingCall.toSvg(
                        height: context.h(16),
                        width: context.h(16),
                      ),
                      context.sbW(8),
                      AppText(
                        timeOfCall,
                        style: TextStyle(
                          fontSize: context.sp(12),
                          color: AppColors.grey600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Call Button
          AppButton(
            onPressed: () {},
            child: AppIcons.voiceCall.toSvg(
              height: context.h(24),
              width: context.h(24),
            ),
          ),
        ],
      ),
    );
  }
}
