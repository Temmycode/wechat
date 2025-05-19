import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';

class ChatTab extends StatelessWidget {
  final bool isActive;
  final String text;
  final VoidCallback onPressed;

  const ChatTab({
    super.key,
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      child: Container(
        margin: EdgeInsets.only(right: context.w(24)),
        alignment: Alignment.center,
        height: context.h(26),
        width: context.w(62),
        decoration: BoxDecoration(
          color: isActive ? AppColors.blue800 : Colors.white,
          borderRadius: BorderRadius.circular(context.r(4)),
        ),
        child: AppText(
          text,
          style: TextStyle(
            fontSize: context.sp(12),
            color: isActive ? Colors.white : AppColors.grey300,
          ),
        ),
      ),
    );
  }
}
