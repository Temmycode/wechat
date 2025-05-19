import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/widgets/conversation_member_tile.dart';

class ConversationMemberList extends StatelessWidget {
  const ConversationMemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.w(16)),
      padding: EdgeInsets.only(
        left: context.w(12),
        right: context.w(12),
        top: context.h(17),
        bottom: context.h(21),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey100),
        borderRadius: BorderRadius.circular(context.r(8)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppIcons.people.toSvg(height: context.h(24)),

              context.sbW(16),

              // length of people
              AppText(
                "9 People",
                style: TextStyle(
                  fontSize: context.sp(12),
                  color: AppColors.black800,
                ),
              ),

              Spacer(),

              // Add user button
              AppButton(
                onPressed: () {},
                child: AppIcons.addPerson.toSvg(height: context.h(24)),
              ),

              context.sbW(16),

              // Search Button
              AppButton(
                onPressed: () {},
                child: AppIcons.search2.toSvg(height: context.h(24)),
              ),
            ],
          ),

          context.sbH(12),

          Divider(color: AppColors.grey100),

          context.sbH(16),

          // Conversation Members
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: context.w(4)),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 9,
            itemBuilder: (context, index) {
              return ConversationMemberTile(
                isAdmin: index == 1 || index == 2,
                isUser: index == 0,
              );
            },
          ),
        ],
      ),
    );
  }
}
