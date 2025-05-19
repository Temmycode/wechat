import 'package:flutter/material.dart';
import 'package:wechat/features/auth/views/create_account_screen.dart';
import 'package:wechat/features/auth/views/login_screen.dart';
import 'package:wechat/features/call/presentation/screens/recent_call_screen.dart';
import 'package:wechat/features/chat/screens/chat_screen.dart';
import 'package:wechat/features/chat/screens/conversation_info_screen.dart';
import 'package:wechat/features/chat/screens/recent_chat_screen.dart';
import 'package:wechat/features/home/presentation/screens/home_screen.dart';
import 'package:wechat/features/profile/views/profile_screen.dart';

class AppRouter {
  static final routes = {
    RecentChatScreen.routeName: (_) => const RecentChatScreen(),
    RecentCallScreen.routeName: (_) => const RecentCallScreen(),
    ChatScreen.routeName: (_) => const ChatScreen(),
    ConversationInfoScreen.routeName: (_) => const ConversationInfoScreen(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    CreateAccountScreen.routeName: (_) => const CreateAccountScreen(),
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
      case ConversationInfoScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ConversationInfoScreen(),
        );
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case CreateAccountScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CreateAccountScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
