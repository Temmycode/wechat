import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.h(30),
      width: context.h(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.r(30)),
        color: AppColors.blue800,
      ),
      child: const Icon(Icons.arrow_forward, color: Colors.white),
    );
  }
}
