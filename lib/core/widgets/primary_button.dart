import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_text.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: context.h(50),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.blue800,
          borderRadius: BorderRadius.circular(context.r(60)),
        ),
        child: Center(
          child:
              isLoading
                  ? SizedBox(
                    height: context.h(20),
                    width: context.h(20),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                  : AppText(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.sp(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
        ),
      ),
    );
  }
}
