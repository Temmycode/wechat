import 'package:flutter/material.dart';
import 'package:wechat/config/route/routes.dart';
import 'package:wechat/config/theme/app_colors.dart';
import 'package:wechat/core/utils/app_navigator.dart';
import 'package:wechat/features/auth/views/login_screen.dart';

class WeChat extends StatelessWidget {
  const WeChat({super.key});

  @override
  Widget build(BuildContext context) {
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
