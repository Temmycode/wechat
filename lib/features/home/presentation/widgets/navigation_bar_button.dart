import 'package:flutter/material.dart';
import 'package:wechat/core/widgets/app_button.dart';

class NavigationBarButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const NavigationBarButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: AppButton(onPressed: onPressed, child: child));
  }
}
