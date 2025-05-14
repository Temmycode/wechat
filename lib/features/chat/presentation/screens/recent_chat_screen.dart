import 'package:flutter/material.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/constants.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/presentation/widgets/chat_tab.dart';
import 'package:wechat/features/chat/presentation/widgets/conversation_list_tile.dart';

class RecentChatScreen extends StatefulWidget {
  const RecentChatScreen({super.key});

  @override
  State<RecentChatScreen> createState() => _RecentChatScreenState();
}

class _RecentChatScreenState extends State<RecentChatScreen>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<TabController> _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this).notifier;
  }

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
                      "Recent Chats",
                      style: TextStyle(
                        fontSize: context.sp(18),
                        fontWeight: FontWeight.w600,
                        color: AppColors.black800,
                      ),
                    ),
                    AppIcons.search.toSvg(
                      height: context.h(24),
                      width: context.h(24),
                    ),
                  ],
                ),
              ),
              floating: true,
              pinned: false,
              snap: true,
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, context.h(30)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.w(16)),
                  child: _tabController.sync(
                    builder: (context, controller, child) {
                      return Row(
                        children: List.generate(chatTabs.length, (index) {
                          final tab = chatTabs[index];
                          return ChatTab(
                            isActive: index == controller.index,
                            text: tab,
                            onPressed: () {
                              // change to the currently pressed tab
                              controller.index = index;
                            },
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
            ),

            // List of Conversation Tiles
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                context.w(8),
                context.h(0),
                context.w(8),
                0,
              ),
              sliver: SliverList.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ConversationListTile();
                },
              ),
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
          child: AppIcons.message.toSvg(),
        ),
      ),
    );
  }
}
