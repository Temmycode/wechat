import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/app_navigator.dart';
import 'package:wechat/core/utils/constants.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/controller/notifiers/chat_notifier.dart';
import 'package:wechat/features/chat/controller/providers/all_conversations_provider.dart';
import 'package:wechat/features/chat/controller/providers/chat_notifier_provider.dart';
import 'package:wechat/features/chat/screens/select_contact_screen.dart';
import 'package:wechat/features/chat/widgets/chat_tab.dart';
import 'package:wechat/features/chat/widgets/conversation_list_tile.dart';

class RecentChatScreen extends ConsumerStatefulWidget {
  static const String routeName = "/conversation";
  const RecentChatScreen({super.key});

  @override
  ConsumerState<RecentChatScreen> createState() => _RecentChatScreenState();
}

class _RecentChatScreenState extends ConsumerState<RecentChatScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;
  late final ValueNotifier<int> _tabIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabIndex = _tabController.index.notifier;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final asyncConversations = ref.watch(allConversationsProvider);

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
              automaticallyImplyLeading: false,
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
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, context.h(40)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.w(16)),
                  child: _tabIndex.sync(
                    builder: (context, value, _) {
                      return Row(
                        children: List.generate(chatTabs.length, (index) {
                          final tab = chatTabs[index];
                          return ChatTab(
                            key: ValueKey(index),
                            isActive: index == value,
                            text: tab,
                            onPressed: () {
                              _tabController.animateTo(index);
                              // change to the currently pressed tab
                              _tabIndex.value = _tabController.index;
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
                context.h(8),
                context.w(8),
                0,
              ),
              sliver: asyncConversations.when(
                data: (conversations) {
                  if (conversations.isEmpty) {
                    return SliverToBoxAdapter(
                      child: AppText("No conversations yet!"),
                    );
                  }

                  return SliverList.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final currentConversation = conversations[index];

                      return ConversationListTile(
                        key: ValueKey(index),
                        conversation: currentConversation,
                      );
                    },
                  );
                },
                error: (err, stk) {
                  return SliverToBoxAdapter(
                    child: AppText("An Error Occurred: $err"),
                  );
                },
                loading: () {
                  return SliverToBoxAdapter(
                    child:
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.blue800,
                          ),
                          strokeWidth: 2,
                        ).center(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AppButton(
        onPressed: () {
          AppNavigator.instance.navigateWithTransition(
            route: SelectContactScreen(),
          );
        },
        child: Container(
          padding: EdgeInsets.all(context.sp(16)),
          height: context.h(56),
          width: context.h(56),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue800,
          ),
          child: AppIcons.addMessage.toSvg(),
        ),
      ),
    );
  }
}
