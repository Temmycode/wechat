import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/utils/permission_service.dart';
import 'package:wechat/core/utils/prefrence_manager.dart';
import 'package:wechat/we_chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager.init();
  await PermissionService.initializePermissions();
  
  runApp(const ProviderScope(child: WeChat()));
}
