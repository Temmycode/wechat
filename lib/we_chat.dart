import 'package:flutter/material.dart';
import 'package:wechat/config/route/routes.dart';
import 'package:wechat/features/home/presentation/screens/home_screen.dart';

class WeChat extends StatelessWidget {
  const WeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WEChat',
      routes: AppRouter.routes,
      onGenerateRoute: AppRouter.generateRoutes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      ),
      home: HomeScreen(),
    );
  }
}
