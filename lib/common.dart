import 'package:flutter/painting.dart';

class Colors {
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color blue = Color(0xff3F38DD);
  static const Color teal = Color(0xff4AD2E4);
  static const Color purple = Color(0xff7655CC);
}

class Fonts {
  static const String sfProDisplay = "SF Pro Display";
  static const String sfProText = "SF Pro Text";
}

class TextStyles {
  static const TextStyle sfProDisplayBold = TextStyle(
      color: Colors.white,
      fontFamily: Fonts.sfProDisplay,
      fontWeight: FontWeight.bold);
  static const TextStyle sfProTextRegular = TextStyle(
      color: Colors.white,
      fontFamily: Fonts.sfProText,
      fontWeight: FontWeight.w400);
}
