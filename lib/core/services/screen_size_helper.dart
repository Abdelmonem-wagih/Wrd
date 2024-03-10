import 'dart:math';

import 'package:flutter/material.dart';

class ScreenSizeHelper {
  static const Size _designSize = Size(360, 760);
  static Size get designSize => _designSize;
  static double height = 0;
  static double width = 0;

  static double get scaleHeight => height / _designSize.height;

  static double get scaleWidth => width / _designSize.width;

  static void init(BuildContext context) async {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}

extension ScreenSizeExtension on num {
  double get height => this * ScreenSizeHelper.scaleHeight;

  double get width => this * ScreenSizeHelper.scaleWidth;

  double get size =>
      (this / 2.3 * ScreenSizeHelper.scaleWidth) +
          (this / 1.7 * ScreenSizeHelper.scaleHeight);

  double get radius =>
      this * min(ScreenSizeHelper.scaleHeight, ScreenSizeHelper.scaleWidth);

  double get fontSize =>
      this * min(ScreenSizeHelper.scaleHeight, ScreenSizeHelper.scaleWidth);

  double get screenHeightFact => this * ScreenSizeHelper.height;

  double get screenWidthFact => this * ScreenSizeHelper.width;

  SizedBox get verticalSpace => SizedBox(
    height: height,
  );

  SizedBox get horizontalSpace => SizedBox(
    width: width,
  );
}
