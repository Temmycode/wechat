import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wechat/core/utils/permission_service.dart';
import 'package:wechat/core/utils/prefrence_manager.dart';
import 'package:wechat/we_chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager.init();
  await PermissionService.initializePermissions();

  await Hive.initFlutter();

  await Hive.openBox("Wechat_Database");

  runApp(const ProviderScope(child: WeChat()));
}
