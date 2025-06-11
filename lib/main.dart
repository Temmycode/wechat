import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wechat/core/utils/permission_service.dart';
import 'package:wechat/core/utils/prefrence_manager.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/auth/models/user_custom_adapter.dart';
import 'package:wechat/features/chat/models/message.dart';
import 'package:wechat/features/chat/models/message_custom_adapter.dart';
import 'package:wechat/we_chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager.init();
  await PermissionService.initializePermissions();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelCustomAdapter());
  Hive.registerAdapter(MessageModelCustomAdapter());

  await Hive.openBox<MessageModel>("MessageBox");
  await Hive.openBox<UserModel>("UserBox");

  runApp(const ProviderScope(child: WeChat()));
}
