import 'dart:math';
import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  double get textScaleFactor => MediaQuery.of(this).textScaler.scale(1.0);

  double sp(double value) {
    return min(
          screenWidth / SizeConfig.baseWidth,
          screenHeight / SizeConfig.baseHeight,
        ) *
        textScaleFactor *
        value;
  }

  double h(double value) {
    return ((screenHeight / SizeConfig.baseHeight) * value).toDouble();
  }

  double w(double value) {
    return ((screenWidth / SizeConfig.baseWidth) * value).toDouble();
  }

  double r(double value) {
    return ((screenWidth / SizeConfig.baseWidth) * value).toDouble();
  }

  SizedBox sbH(double value) {
    return SizedBox(
      height: ((screenHeight / SizeConfig.baseHeight) * value).toDouble(),
    );
  }

  SizedBox sbW(double value) {
    return SizedBox(
      width: ((screenWidth / SizeConfig.baseWidth) * value).toDouble(),
    );
  }
}

class SizeConfig {
  static double baseWidth = 375;
  static double baseHeight = 812;
}

double height(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double width(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}
