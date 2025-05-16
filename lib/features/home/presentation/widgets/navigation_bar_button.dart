import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:wechat/core/utils/app_animations.dart';
import 'package:wechat/core/utils/size_config.dart';
import 'package:wechat/core/widgets/app_button.dart';

class NavigationBarButton extends StatefulWidget {
  final String icon;
  final VoidCallback onPressed;

  const NavigationBarButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<NavigationBarButton> createState() => _NavigationBarButtonState();
}

class _NavigationBarButtonState extends State<NavigationBarButton> {
  late RiveAnimationController _idleController;
  RiveAnimationController? _activeController;
  Artboard? _artboard;

  @override
  void initState() {
    super.initState();

    RiveFile.initialize();

    // Load artboard manually so we can control animation
    rootBundle.load(AppAnimations.animatedIcons).then((data) {
      final file = RiveFile.import(data);
      final artboard = file.artboardByName(widget.icon);
      if (artboard != null) {
        _idleController = SimpleAnimation('idle');
        artboard.addController(_idleController);
        setState(() {
          _artboard = artboard;
        });
      }
    });
  }

  void _playActiveAnimation() {
    if (_artboard == null) return;

    // Remove idle controller
    _artboard!.removeController(_idleController);

    // Add active controller
    _activeController = SimpleAnimation(
      'active',

      // On completion, remove active and go back to idle
    );

    Future.delayed(Duration(seconds: 2), () {
      if (_activeController != null) {
        _artboard!.removeController(_activeController!);
        _artboard!.addController(_idleController);
      }
    });

    _artboard!.addController(_activeController!);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppButton(
        onPressed: () {
          widget.onPressed();
          _playActiveAnimation();
        },
        child: SizedBox(
          height: context.h(34),
          child:
              _artboard != null ? Rive(artboard: _artboard!) : const SizedBox(),
        ),
      ),
    );
  }
}
