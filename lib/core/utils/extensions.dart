import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension StringToSVG on String {
  Widget toSvg({double? height, double? width}) {
    return SvgPicture.asset(this, height: height, width: width);
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
