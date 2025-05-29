import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/chat/controller/notifiers/we_chat_contact_users_notifier.dart';

final weChatContactUsersProvider =
    AsyncNotifierProvider<WeChatContactUsersNotifier, List<UserModel>>(
      WeChatContactUsersNotifier.new,
    );
