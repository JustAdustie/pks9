import 'package:flutter/material.dart';

class AppStyles {
  static const Color backgroundColor = Color(0xFFD6EAF8);
  static const Color appBarColor = Color(0xFF5DADE2);
  // Text styles
  static const TextStyle appBarTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 21.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF34495E),
  );

  static const TextStyle hintTextStyle = TextStyle(
    color: Color(0xFF9B59B6),
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  // Button style
  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: const Color(0xFFE74C3C),
    backgroundColor: const Color(0xFFBB8FCE),
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(width: 2, color: Color(0xFFE74C3C)),
    ),
  );
}
