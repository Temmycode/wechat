import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/src/gestures/recognizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/core/utils/constants.dart';
import 'package:wechat/core/utils/extensions.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/chat/presentation/widgets/conversation_member_list.dart';

class ConversationInfoScreen extends StatefulWidget {
  static const String routeName = "/converstaion/chat/converstaion-info";

  const ConversationInfoScreen({super.key});

  @override
  State<ConversationInfoScreen> createState() => _ConversationInfoScreenState();
}

class _ConversationInfoScreenState extends State<ConversationInfoScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: conversationInfoTabItems.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // CachedNetworkImage(
              //   imageUrl:
              //       'https://m.media-amazon.com/images/I/71LEWdTTxpL._AC_SL1280_.jpg',
              //   fit: BoxFit.cover,
              //   height: context.h(166),
              //   width: double.infinity,
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.grey600,
                        size: context.sp(24),
                      ),
                    ),
                    AppText(
                      "Fullsnack Designers",
                      style: TextStyle(
                        fontSize: context.sp(18),
                        fontWeight: FontWeight.w500,
                        color: AppColors.black800,
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: AppColors.grey600,
                      size: context.sp(24),
                    ),
                  ],
                ),
              ),

              context.sbH(49),

              Padding(
                padding: EdgeInsets.only(
                  left: context.w(32),
                  bottom: context.h(24),
                ),
                child: Row(
                  children: [
                    AppIcons.infoOutlined.toSvg(
                      height: context.h(24),
                      width: context.h(24),
                    ),

                    context.sbW(16),

                    SizedBox(
                      width: context.w(259),
                      child: AppText(
                        "We are fullsnack designers, yes. From food, for food, by food!",
                        style: TextStyle(
                          fontSize: context.sp(14),
                          color: AppColors.grey600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(color: AppColors.grey100),

              // Tab bar
              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  padding: EdgeInsets.symmetric(horizontal: context.w(16)),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  controller: _tabController,
                  indicatorWeight: 5,
                  indicatorColor: AppColors.blue800,
                  dividerHeight: 0,
                  labelColor: AppColors.blue800,
                  labelStyle: GoogleFonts.plusJakartaSans(
                    fontSize: context.sp(12),
                    fontWeight: FontWeight.w600,
                  ),
                  tabs:
                      conversationInfoTabItems.map((tab) {
                        final name = tab['name']! as String;
                        final icon = tab['icons']! as IconData;
                        return Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // 👈 important
                            children: [
                              Icon(icon, size: context.sp(16)),
                              context.sbW(8),
                              AppText(name),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),

              context.sbH(24),

              // Members of Conversation
              ConversationMemberList(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
