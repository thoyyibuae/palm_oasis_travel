import 'package:flutter/material.dart';

class BasicColors {
  static const Color kScaffold = Color(0xFFF0F2F5);
  static const Color kLightYellow = Color(0xFFFFF9EC);
  static const Color kLightYellow2 = Color(0xFFFFE4C7);
  // static const Color kDarkYellow = Color(0xFFF9BE7C);
  static const Color kPalePink = Color(0xFFFED4D6);
  static const Color kLightText = Colors.white60;

  static const Color kRed = Color(0xFFE46472);
  static const Color kLavender = Color(0xFFD5E4FE);
  static const Color kBlue = Color(0xFF6488E4);
  static const Color kLightGreen = Color(0xFFD9E6DC);
  static const Color kGreen = Color(0xFF309397);

  static const Color kDarkBlue = Color(0xFF0D253F);

  static const Color kWisteria = Color(0xFFA46FB8);

  static const Color kTopBar = Colors.black87;
  static const Color kBottomBar = Color(0xFFEF5350);

  // static const Color kPrice = Color(0xFFF9BE7C);

  static const Color kBorder = Colors.white70;

  static const kBackgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[BasicColors.kTopBar, BasicColors.kBottomBar]);

  static const kBackgroundGradientDecoration =
      BoxDecoration(gradient: kBackgroundGradient);
  static InputDecoration kLoginPageTextInputDecoration(
          IconData icon, String hintText) =>
      InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(40.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Color.fromRGBO(81, 165, 243, 1),
      );

  static const Color kTitle = Color(0xFFFFA500);
}
