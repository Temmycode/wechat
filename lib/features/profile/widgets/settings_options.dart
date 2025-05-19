import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_text.dart';

class SettingsOptions extends StatelessWidget {
  final Map<String, String> setting;
  final Widget? trailing;

  const SettingsOptions({super.key, required this.setting, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h(53),
      margin: EdgeInsets.only(
        left: context.w(8),
        right: context.w(8),
        bottom: context.h(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: context.w(24)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.r(8)),
      ),
      child: Row(
        children: [
          setting['icon']!.toSvg(height: context.h(24), width: context.h(24)),
          context.sbW(16),
          AppText(
            setting['name']!,
            style: TextStyle(
              fontSize: context.sp(14),
              color: AppColors.grey600,
            ),
          ),
          Spacer(),
          trailing ??
              Icon(
                Icons.chevron_right,
                size: context.sp(24),
                color: AppColors.grey400,
              ),
        ],
      ),
    );
  }
}
