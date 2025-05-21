import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final bool withBanner;
  final bool isNetwork;

  const UserAvatar({
    super.key,
    this.imageUrl,
    this.size,
    this.withBanner = true,
    this.isNetwork = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isNetwork
            ? ClipRRect(
              borderRadius: BorderRadius.circular(context.r(size ?? 48)),
              child: CachedNetworkImage(
                height: context.h(size ?? 48),
                width: context.h(size ?? 48),
                fit: BoxFit.cover,
                imageUrl: imageUrl!,
                errorWidget: (context, url, error) => Icon(Icons.error),
                placeholder:
                    (context, url) => Container(color: AppColors.grey100),
              ),
            )
            : CircleAvatar(
              backgroundColor: Colors.white,
              radius: context.r(30),
              child: Icon(Icons.person_outline, size: context.sp(40)),
            ),

        Positioned(
          right: 0,
          bottom: 0,
          child:
              isNetwork && withBanner
                  ? Container(
                    height: context.h(12),
                    width: context.h(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.yellow400,
                      border: Border.all(width: 2.2, color: Colors.white),
                    ),
                  )
                  : Container(),
        ),
      ],
    );
  }
}
