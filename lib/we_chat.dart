import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/config/route/routes.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_navigator.dart';
import 'package:wechat/features/auth/views/login_screen.dart';
import 'package:wechat/features/chat/controller/providers/chat_notifier_provider.dart';

class WeChat extends ConsumerWidget {
  const WeChat({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // +2345554787672
    ref.watch(chatNotifierProvider); // call to initialize contacts

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WEChat',
      navigatorKey: AppNavigator.instance.navigatorKey,
      routes: AppRouter.routes,
      onGenerateRoute: AppRouter.generateRoutes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue800),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      ),
      home: LoginScreen(),
    );
  }
}
