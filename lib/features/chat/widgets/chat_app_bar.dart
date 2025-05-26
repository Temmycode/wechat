import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/screens/conversation_info_screen.dart';
import 'package:wechat/features/chat/widgets/user_avatar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? imageUrl;
  final String name;

  const ChatAppBar({
    super.key,
    required this.height,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final safeAreaInests = MediaQuery.of(context).padding;

    return Container(
      padding: EdgeInsets.only(top: safeAreaInests.top),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.grey100)),
      ),
      child: Row(
        children: [
          AppButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.grey600,
              size: context.sp(24),
            ),
          ),

          context.sbW(8),

          AppButton(
            onPressed: () {
              Navigator.pushNamed(context, ConversationInfoScreen.routeName);
            },
            child: Row(
              children: [
                if (imageUrl == null || imageUrl!.isEmpty)
                  UserAvatar(
                    size: 48,
                    isNetwork: false,
                    withBanner: false,
                    backgroundColor: AppColors.blue200,
                  )
                else
                  ClipRRect(
                    borderRadius: BorderRadius.circular(context.r(48)),
                    child: CachedNetworkImage(
                      height: context.w(48),
                      width: context.w(48),
                      fit: BoxFit.cover,
                      imageUrl: imageUrl!,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      placeholder:
                          (context, url) => Container(color: AppColors.grey100),
                    ),
                  ),

                context.sbW(10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      name,
                      style: TextStyle(
                        fontSize: context.sp(18),
                        fontWeight: FontWeight.w500,
                        color: AppColors.black800,
                      ),
                    ),
                    context.sbH(2),
                    AppText(
                      "Online",
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

          Spacer(),

          AppButton(
            onPressed: () {},
            child: AppIcons.videoCall.toSvg(
              height: context.h(24),
              width: context.h(24),
            ),
          ),
          context.sbW(10),

          AppButton(
            onPressed: () {},
            child: Icon(
              Icons.more_vert,
              size: context.sp(24),
              color: AppColors.grey600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height);
}
