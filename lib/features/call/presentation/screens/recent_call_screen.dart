import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/call/presentation/widgets/call_list_tile.dart';

class RecentCallScreen extends StatefulWidget {
  const RecentCallScreen({super.key});

  @override
  State<RecentCallScreen> createState() => _RecentCallScreenState();
}

class _RecentCallScreenState extends State<RecentCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              backgroundColor: AppColors.offWhite,
              surfaceTintColor: AppColors.offWhite,
              titleSpacing: 0,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      "Recent Calls",
                      style: TextStyle(
                        fontSize: context.sp(18),
                        fontWeight: FontWeight.w600,
                        color: AppColors.black800,
                      ),
                    ),

                    // Search Button
                    AppButton(
                      onPressed: () {},
                      child: AppIcons.search.toSvg(
                        height: context.h(24),
                        width: context.h(24),
                      ),
                    ),
                  ],
                ),
              ),
              floating: true,
              pinned: false,
              snap: true,
            ),

            // List of Conversation Tiles
            SliverList.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return CallListTile();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: AppButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.all(context.sp(16)),
          height: context.h(56),
          width: context.h(56),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue800,
          ),
          child: AppIcons.addCall.toSvg(),
        ),
      ),
    );
  }
}
