import 'package:flutter/material.dart';
import 'package:tutvideo/utils/helpers/screen_size.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static double responsiveRatio(BuildContext context, [double height = 1]) =>
      height * ScreenSize.width(context) / 1200;

  static bool isMobile(BuildContext context) => ScreenSize.width(context) < 800;

  static bool isTablet(BuildContext context) =>
      ScreenSize.width(context) >= 800 && ScreenSize.width(context) < 1200;

  static bool isDesktop(BuildContext context) =>
      ScreenSize.width(context) >= 800;

  static int crossAxisCount(BuildContext context, double unitWidth,
      {int minimumCount = 1, double widthMinusDelta = 0}) {
    int crossAxisCount =
        (ScreenSize.width(context) - widthMinusDelta) ~/ unitWidth;
    if (crossAxisCount < 1) crossAxisCount = 1;
    return crossAxisCount;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // if (kIsWeb) {
      //   print("It's web");
      // } else {
      //   print("It's not web");
      // }
      if (constraints.maxWidth >= 800) {
        //1200
        return desktop;
        // } else if (constraints.maxWidth >= 800) {
        // return tablet ?? mobile;
      } else {
        return mobile;
      }
    });
  }
}
