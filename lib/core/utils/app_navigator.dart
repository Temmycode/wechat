import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:developer' as dev;

class AppNavigator {
  static AppNavigator? _instance;

  AppNavigator._internal();

  static AppNavigator get instance {
    _instance ??= AppNavigator._internal();
    return _instance!;
  }

  // NAVIGATOR KEYS
  final navigatorKey = GlobalKey<NavigatorState>();
  final snackBarKey = GlobalKey<ScaffoldMessengerState>();

  void goBack() => navigatorKey.currentState!.pop();

  // Navigate to Page Without removing previous page from STACK
  Future<void> navigateToPage({
    required String routeName,
    Object? arguments,
  }) async {
    // Get the current route name safely
    String? currentRoute =
        navigatorKey.currentContext != null
            ? ModalRoute.of(navigatorKey.currentContext!)?.settings.name
            : null;

    if (currentRoute == null || currentRoute != routeName) {
      await navigatorKey.currentState!.pushNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      dev.log("Already on the current route: $currentRoute");
    }
  }

  Future<void> navigatePageReplacement({
    required String routeName,
    Object? arguments,
  }) async {
    await navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<void> pushAndRemoveUntil({
    required String routeName,
    Object? arguments,
  }) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void popUntil({required String routeName}) {
    navigatorKey.currentState!.popUntil(
      (route) => route.settings.name == routeName,
    );
  }

  void popUntilFirst() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> pushAndRemoveUnitlWithTransition({required Widget route}) async {
    await navigatorKey.currentState!.pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: 800.ms,
        pageBuilder: (context, animation, secondaryAnimation) {
          return route;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.fastLinearToSlowEaseIn,
          );

          final slideAnimation = Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(curvedAnimation);

          return SlideTransition(position: slideAnimation, child: child);
        },
      ),
      (route) => false,
    );
  }
}
