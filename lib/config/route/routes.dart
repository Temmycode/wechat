import 'package:flutter/material.dart';
import 'package:wechat/features/call/presentation/screens/recent_call_screen.dart';
import 'package:wechat/features/chat/presentation/screens/chat_screen.dart';
import 'package:wechat/features/chat/presentation/screens/recent_chat_screen.dart';
import 'package:wechat/features/home/presentation/screens/home_screen.dart';
import 'package:wechat/features/profile/presentation/screens/profile_screen.dart';

class AppRouter {
  static final routes = {
    RecentChatScreen.routeName: (_) => const RecentChatScreen(),
    RecentCallScreen.routeName: (_) => const RecentCallScreen(),
    ChatScreen.routeName: (_) => const ChatScreen(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
  };

  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    final name = routeSettings.name;

    switch (name) {
      case RecentChatScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RecentChatScreen(),
        );
      case RecentCallScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RecentCallScreen(),
        );
      case ChatScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ChatScreen());
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
