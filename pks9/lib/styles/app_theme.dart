import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFFD6EAF8);
  static const Color cardColor = Color(0xFFBB8FCE);
  static const Color primaryTextColor = Colors.white;
  static const Color secondaryTextColor = Color(0xFF9B59B6);

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: primaryTextColor,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: secondaryTextColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static const EdgeInsets defaultPadding = EdgeInsets.all(15.0);
}
