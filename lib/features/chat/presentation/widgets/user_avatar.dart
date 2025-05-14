import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';

class UserAvatar extends StatelessWidget {
  final String imageUrl;

  const UserAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(context.r(48)),
          child: CachedNetworkImage(
            height: context.h(48),
            width: context.h(48),
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            errorWidget: (context, url, error) => Icon(Icons.error),
            placeholder: (context, url) => Container(color: AppColors.grey200),
          ),
        ),

        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: context.h(12),
            width: context.h(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.yellow400,
              border: Border.all(width: 3, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
