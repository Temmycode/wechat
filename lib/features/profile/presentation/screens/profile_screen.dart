import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/constants.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/profile/presentation/widgets/settings_options.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: context.h(12),
                left: context.w(24),
                right: context.w(24),
              ),
              child: Column(
                children: [
                  AppText(
                    "Settings",
                    style: TextStyle(
                      fontSize: context.sp(18),
                      fontWeight: FontWeight.w600,
                      color: AppColors.black800,
                    ),
                  ).left(),

                  userProfileSection(context),
                ],
              ),
            ),

            context.sbH(24),

            Divider(color: AppColors.offWhite3),

            context.sbH(18),

            // Settings Options
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SettingsOptions(
                  setting: settingsOptions[0],
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),

                for (int i = 1; i < settingsOptions.length; i++) ...[
                  AppButton(
                    onPressed: () {},
                    child: SettingsOptions(setting: settingsOptions[i]),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget userProfileSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.h(24)),
      child: Row(
        children: [
          // Profile Picture
          ClipRRect(
            borderRadius: BorderRadius.circular(context.r(64)),
            child: CachedNetworkImage(
              imageUrl:
                  'https://i.pinimg.com/736x/53/3b/73/533b7305cd22441f8327c49498c7c2d1.jpg',
              fit: BoxFit.cover,
              height: context.h(64),
              width: context.h(64),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              placeholder:
                  (context, url) => Container(color: AppColors.grey100),
            ),
          ),

          context.sbW(24),

          // User Details
          SizedBox(
            width: context.w(168),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Adina Nurrahma',
                  style: TextStyle(
                    fontSize: context.sp(18),
                    fontWeight: FontWeight.w500,
                    color: AppColors.black800,
                  ),
                ),
                context.sbH(8),
                AppText(
                  'Trust your feelins, be a good human being',
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
    );
  }
}
