import 'package:flutter/cupertino.dart';
import 'package:wechat/core/utils/app_icons.dart';
import 'package:wechat/features/call/presentation/screens/recent_call_screen.dart';
import 'package:wechat/features/chat/screens/recent_chat_screen.dart';
import 'package:wechat/features/profile/views/profile_screen.dart';

const chatTabs = ['All chats', 'Groups'];

const settingsOptions = [
  {'name': 'Dark mode', 'icon': AppIcons.moon},
  {'name': 'Account', 'icon': AppIcons.person},
  {'name': 'Notification', 'icon': AppIcons.bell},
  {'name': 'Chat settings', 'icon': AppIcons.message},
  {'name': 'Data and storage', 'icon': AppIcons.storage},
  {'name': 'Privacy & security', 'icon': AppIcons.lock},
  {'name': 'About', 'icon': AppIcons.info},
];

const pages = [RecentChatScreen(), RecentCallScreen(), ProfileScreen()];

const navBarIcons = ["CHAT", "AUDIO", "USER"];

const conversationInfoTabItems = [
  {'name': 'Bookmarks', 'icons': CupertinoIcons.star},
  {'name': 'Images', 'icons': CupertinoIcons.photo},
  {'name': 'Videos', 'icons': CupertinoIcons.video_camera},
  {'name': 'Documents', 'icons': CupertinoIcons.doc},
];
