import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension StringToSVG on String {
  Widget toSvg({double? height, double? width, Color? color}) {
    return SvgPicture.asset(this, height: height, width: width, color: color);
  }
}

/// Extension for creating a ValueNotifier from a value directly.
extension ValueNotifierExtension<T> on T {
  ValueNotifier<T> get notifier {
    return ValueNotifier<T>(this);
  }
}

/// extension for listening to ValueNotifier instances.
extension ValueNotifierBuilderExtension<T> on ValueNotifier<T> {
  Widget sync({
    required Widget Function(BuildContext context, T value, Widget? child)
    builder,
  }) {
    return ValueListenableBuilder<T>(valueListenable: this, builder: builder);
  }
}

extension ListenableBuilderExtension on List<Listenable> {
  Widget multiSync({
    required Widget Function(BuildContext context, Widget? child) builder,
  }) {
    return ListenableBuilder(
      listenable: Listenable.merge(this),
      builder: builder,
    );
  }
}

extension AlignWidget on Widget {
  Align left() {
    return Align(alignment: Alignment.centerLeft, child: this);
  }

  Align right() {
    return Align(alignment: Alignment.centerRight, child: this);
  }

  Align bottom() {
    return Align(alignment: Alignment.bottomCenter, child: this);
  }

  Align top() {
    return Align(alignment: Alignment.topCenter, child: this);
  }

  Align center() {
    return Align(alignment: Alignment.center, child: this);
  }

  Align topRight() {
    return Align(alignment: Alignment.topRight, child: this);
  }

  Align topLeft() {
    return Align(alignment: Alignment.topLeft, child: this);
  }

  Align bottomRight() {
    return Align(alignment: Alignment.bottomRight, child: this);
  }

  Align bottomLeft() {
    return Align(alignment: Alignment.bottomLeft, child: this);
  }
}
