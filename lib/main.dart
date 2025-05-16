import 'package:flutter/material.dart';
import 'package:wechat/core/utils/prefrence_manager.dart';
import 'package:wechat/we_chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrenceManager.init();
  runApp(const WeChat());
}
