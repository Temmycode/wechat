import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';
import 'package:wechat/core/widgets/app_text.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/chat/controller/providers/chat_notifier_provider.dart';
import 'package:wechat/features/chat/controller/providers/we_chat_contact_users_provider.dart';
import 'package:wechat/features/chat/widgets/contact_tile.dart';

class SelectContactScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';

  const SelectContactScreen({super.key});

  void startConversation(WidgetRef ref, UserModel user) {
    ref.read(chatNotifierProvider.notifier).startConverstaion(user: user);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationUsers = ref.watch(weChatContactUsersProvider);

    return Scaffold(
      appBar: AppBar(
        leading: AppButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.grey600,
            // size: context.sp(24),
          ),
        ),
        title: AppText(
          'New Chat',
          style: TextStyle(fontSize: context.sp(20), color: AppColors.black800),
        ),
      ),
      body: SingleChildScrollView(
        // physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            context.sbH(10),

            applicationUsers.when(
              data: (users) {
                if (users.isEmpty) {
                  return AppText("Nothing yet");
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return ContactTile(
                      onPressed: () => startConversation(ref, user),
                      user: user,
                    );
                  },
                );
              },
              loading: () => CircularProgressIndicator(),
              error: (err, stk) => Text(err.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
