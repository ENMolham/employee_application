import 'package:flutter/widgets.dart';

extension ScreenSizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenAspectRatio => MediaQuery.of(this).size.aspectRatio;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;

  static const double figmaWidth = 1920;
  static const double figmaHeight = 1073;

  double fontSize(double figmaSize) => screenWidth * (figmaSize / figmaWidth);

  double iconSize(double figmaSize) => screenWidth * (figmaSize / figmaWidth);

  double width(double fWidth) => screenWidth * (fWidth / figmaWidth);

  double height(double fHeight) => screenHeight * (fHeight / figmaHeight);
}
